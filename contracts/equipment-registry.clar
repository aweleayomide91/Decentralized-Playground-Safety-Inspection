;; Equipment Registration Contract
;; Records details of playground installations

(define-data-var last-equipment-id uint u0)

(define-map equipment-registry
  { equipment-id: uint }
  {
    name: (string-ascii 100),
    location: (string-ascii 100),
    installation-date: uint,
    manufacturer: (string-ascii 100),
    last-inspection-date: uint,
    status: (string-ascii 20)
  }
)

(define-public (register-equipment
    (name (string-ascii 100))
    (location (string-ascii 100))
    (installation-date uint)
    (manufacturer (string-ascii 100)))
  (let ((new-id (+ (var-get last-equipment-id) u1)))
    (begin
      (var-set last-equipment-id new-id)
      (map-set equipment-registry
        { equipment-id: new-id }
        {
          name: name,
          location: location,
          installation-date: installation-date,
          manufacturer: manufacturer,
          last-inspection-date: u0,
          status: "new"
        }
      )
      (ok new-id)
    )
  )
)

(define-read-only (get-equipment (equipment-id uint))
  (ok (map-get? equipment-registry { equipment-id: equipment-id }))
)

(define-read-only (get-equipment-count)
  (ok (var-get last-equipment-id))
)

(define-public (update-equipment-status (equipment-id uint) (status (string-ascii 20)))
  (let ((equipment (map-get? equipment-registry { equipment-id: equipment-id })))
    (if (is-some equipment)
      (begin
        (map-set equipment-registry
          { equipment-id: equipment-id }
          (merge (unwrap-panic equipment) { status: status })
        )
        (ok true)
      )
      (err u1) ;; Equipment not found
    )
  )
)

