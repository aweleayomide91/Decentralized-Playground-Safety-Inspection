;; Incident Reporting Contract
;; Records accidents and identifies safety improvements

(define-data-var last-incident-id uint u0)

(define-map incidents
  { incident-id: uint }
  {
    equipment-id: uint,
    date: uint,
    description: (string-ascii 500),
    severity: (string-ascii 20),
    reported-by: principal,
    witnesses: (optional (string-ascii 500)),
    injuries: (optional (string-ascii 500)),
    follow-up-actions: (optional (string-ascii 500)),
    status: (string-ascii 20)
  }
)

(define-map equipment-incident-history
  { equipment-id: uint }
  { incident-ids: (list 100 uint) }
)

(define-public (report-incident
    (equipment-id uint)
    (description (string-ascii 500))
    (severity (string-ascii 20))
    (witnesses (optional (string-ascii 500)))
    (injuries (optional (string-ascii 500))))
  (let (
    (new-id (+ (var-get last-incident-id) u1))
    (current-time (unwrap-panic (get-block-info? time (- block-height u1))))
  )
    (begin
      (var-set last-incident-id new-id)

      ;; Create incident record
      (map-set incidents
        { incident-id: new-id }
        {
          equipment-id: equipment-id,
          date: current-time,
          description: description,
          severity: severity,
          reported-by: tx-sender,
          witnesses: witnesses,
          injuries: injuries,
          follow-up-actions: none,
          status: "reported"
        }
      )

      ;; Update equipment incident history
      (match (map-get? equipment-incident-history { equipment-id: equipment-id })
        history (map-set equipment-incident-history
          { equipment-id: equipment-id }
          { incident-ids: (unwrap-panic (as-max-len? (append (get incident-ids history) new-id) u100)) }
        )
        (map-set equipment-incident-history
          { equipment-id: equipment-id }
          { incident-ids: (list new-id) }
        )
      )

      (ok new-id)
    )
  )
)

(define-public (update-incident-status
    (incident-id uint)
    (status (string-ascii 20))
    (follow-up-actions (optional (string-ascii 500))))
  (let ((incident (map-get? incidents { incident-id: incident-id })))
    (if (is-some incident)
      (begin
        (map-set incidents
          { incident-id: incident-id }
          (merge (unwrap-panic incident) {
            status: status,
            follow-up-actions: follow-up-actions
          })
        )
        (ok true)
      )
      (err u1) ;; Incident not found
    )
  )
)

(define-read-only (get-incident (incident-id uint))
  (ok (map-get? incidents { incident-id: incident-id }))
)

(define-read-only (get-equipment-incident-history (equipment-id uint))
  (ok (map-get? equipment-incident-history { equipment-id: equipment-id }))
)

