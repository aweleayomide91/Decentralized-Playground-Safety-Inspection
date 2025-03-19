;; Inspection Scheduling Contract
;; Manages regular safety checks

(define-data-var last-inspection-id uint u0)

(define-map inspections
  { inspection-id: uint }
  {
    equipment-id: uint,
    inspector: principal,
    scheduled-date: uint,
    completed-date: (optional uint),
    status: (string-ascii 20),
    findings: (optional (string-ascii 500))
  }
)

(define-map equipment-inspection-schedule
  { equipment-id: uint }
  {
    frequency-days: uint,
    last-inspection-date: uint,
    next-inspection-date: uint
  }
)

(define-public (schedule-inspection
    (equipment-id uint)
    (inspector principal)
    (scheduled-date uint))
  (let ((new-id (+ (var-get last-inspection-id) u1)))
    (begin
      (var-set last-inspection-id new-id)
      (map-set inspections
        { inspection-id: new-id }
        {
          equipment-id: equipment-id,
          inspector: inspector,
          scheduled-date: scheduled-date,
          completed-date: none,
          status: "scheduled",
          findings: none
        }
      )
      (ok new-id)
    )
  )
)

(define-public (set-inspection-frequency
    (equipment-id uint)
    (frequency-days uint))
  (let ((current-time (unwrap-panic (get-block-info? time (- block-height u1)))))
    (begin
      (map-set equipment-inspection-schedule
        { equipment-id: equipment-id }
        {
          frequency-days: frequency-days,
          last-inspection-date: u0,
          next-inspection-date: (+ current-time (* frequency-days u86400))
        }
      )
      (ok true)
    )
  )
)

(define-public (complete-inspection
    (inspection-id uint)
    (findings (string-ascii 500)))
  (let (
    (inspection (map-get? inspections { inspection-id: inspection-id }))
    (current-time (unwrap-panic (get-block-info? time (- block-height u1))))
  )
    (if (is-some inspection)
      (let ((inspection-data (unwrap-panic inspection)))
        (begin
          ;; Update inspection record
          (map-set inspections
            { inspection-id: inspection-id }
            (merge inspection-data {
              completed-date: (some current-time),
              status: "completed",
              findings: (some findings)
            })
          )

          ;; Update equipment schedule
          (match (map-get? equipment-inspection-schedule { equipment-id: (get equipment-id inspection-data) })
            schedule-data (map-set equipment-inspection-schedule
              { equipment-id: (get equipment-id inspection-data) }
              (merge schedule-data {
                last-inspection-date: current-time,
                next-inspection-date: (+ current-time (* (get frequency-days schedule-data) u86400))
              })
            )
            true
          )

          (ok true)
        )
      )
      (err u1) ;; Inspection not found
    )
  )
)

(define-read-only (get-inspection (inspection-id uint))
  (ok (map-get? inspections { inspection-id: inspection-id }))
)

(define-read-only (get-due-inspections (current-time uint))
  (ok true) ;; In a real implementation, this would return a list of due inspections
)

