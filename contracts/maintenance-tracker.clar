;; Maintenance Tracking Contract
;; Monitors repairs and replacements

(define-data-var last-maintenance-id uint u0)

(define-map maintenance-records
  { maintenance-id: uint }
  {
    equipment-id: uint,
    maintenance-type: (string-ascii 50),
    description: (string-ascii 500),
    performed-by: principal,
    date: uint,
    cost: uint,
    parts-replaced: (optional (string-ascii 500))
  }
)

(define-map equipment-maintenance-history
  { equipment-id: uint }
  { maintenance-ids: (list 100 uint) }
)

(define-public (record-maintenance
    (equipment-id uint)
    (maintenance-type (string-ascii 50))
    (description (string-ascii 500))
    (cost uint)
    (parts-replaced (optional (string-ascii 500))))
  (let (
    (new-id (+ (var-get last-maintenance-id) u1))
    (current-time (unwrap-panic (get-block-info? time (- block-height u1))))
  )
    (begin
      (var-set last-maintenance-id new-id)

      ;; Create maintenance record
      (map-set maintenance-records
        { maintenance-id: new-id }
        {
          equipment-id: equipment-id,
          maintenance-type: maintenance-type,
          description: description,
          performed-by: tx-sender,
          date: current-time,
          cost: cost,
          parts-replaced: parts-replaced
        }
      )

      ;; Update equipment maintenance history
      (match (map-get? equipment-maintenance-history { equipment-id: equipment-id })
        history (map-set equipment-maintenance-history
          { equipment-id: equipment-id }
          { maintenance-ids: (unwrap-panic (as-max-len? (append (get maintenance-ids history) new-id) u100)) }
        )
        (map-set equipment-maintenance-history
          { equipment-id: equipment-id }
          { maintenance-ids: (list new-id) }
        )
      )

      (ok new-id)
    )
  )
)

(define-read-only (get-maintenance-record (maintenance-id uint))
  (ok (map-get? maintenance-records { maintenance-id: maintenance-id }))
)

(define-read-only (get-equipment-maintenance-history (equipment-id uint))
  (ok (map-get? equipment-maintenance-history { equipment-id: equipment-id }))
)

