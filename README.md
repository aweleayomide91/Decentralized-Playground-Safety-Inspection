# Decentralized Playground Safety Inspection

A blockchain-based system for transparent, accountable management of playground safety inspections, maintenance, and incident reporting.

## Overview

This project implements a suite of smart contracts to ensure the safety of public and private playgrounds through decentralized verification, scheduling, and record-keeping. By leveraging blockchain technology, we create an immutable record of playground equipment, inspections, maintenance, and incidents, improving accountability and safety for children.

## Key Features

- **Transparent equipment records** - Publicly verifiable information about playground installations
- **Automated inspection scheduling** - Timely safety checks with inspector verification
- **Comprehensive maintenance tracking** - Clear history of repairs and replacements
- **Secure incident reporting** - Privacy-preserving accident records for safety improvements
- **Stakeholder accountability** - Clear responsibility tracking for playground owners, inspectors, and maintenance crews

## Smart Contracts

### 1. Equipment Registration Contract

Manages the registration and lifecycle tracking of playground equipment installations.

**Functionality:**
- Equipment registration with detailed specifications
- Manufacturer verification and warranty information
- Installation certification and documentation
- Equipment lifecycle tracking
- Compliance with safety standards verification
- Transfer of ownership management

### 2. Inspection Scheduling Contract

Coordinates and verifies regular safety inspections of registered playground equipment.

**Functionality:**
- Automated inspection scheduling based on equipment type and regulations
- Inspector qualification verification
- Inspection checklist management
- Pass/fail determination with detailed documentation
- Notification system for upcoming and overdue inspections
- Inspection history for each playground

### 3. Maintenance Tracking Contract

Records all maintenance activities performed on playground equipment.

**Functionality:**
- Maintenance request creation and assignment
- Repair verification and documentation
- Parts replacement tracking
- Maintenance history for each piece of equipment
- Scheduled maintenance reminders
- Maintenance crew certification verification

### 4. Incident Reporting Contract

Securely records and analyzes playground accidents and safety issues.

**Functionality:**
- Privacy-preserving incident reporting
- Severity classification system
- Automatic notification to relevant stakeholders
- Root cause analysis recording
- Corrective action tracking
- Statistical analysis for safety improvements
- Regulatory compliance reporting

## Technical Architecture

The system uses a combination of on-chain and off-chain components:

- **Smart Contracts**: Deployed on Ethereum (or compatible blockchain)
- **Front-end Interface**: Web and mobile applications for different stakeholders
- **IPFS Storage**: For storing inspection reports, images, and maintenance documentation
- **Oracle Services**: To connect with weather data, equipment recall notices, and regulatory updates

## Getting Started

### Prerequisites

- Node.js (v16+)
- Truffle Suite
- MetaMask or similar web3 wallet
- Ganache (for local development)

### Installation

1. Clone the repository:
   ```
   git clone https://github.com/yourusername/playground-safety-inspection.git
   cd playground-safety-inspection
   ```

2. Install dependencies:
   ```
   npm install
   ```

3. Compile smart contracts:
   ```
   truffle compile
   ```

4. Deploy to local network:
   ```
   truffle migrate --reset
   ```

### Testing

Run the automated test suite:
```
truffle test
```

## Deployment

### Local Development
1. Start Ganache local blockchain
2. Deploy contracts with `truffle migrate`
3. Connect MetaMask to your local Ganache instance
4. Run the front-end with `npm start`

### Testnet/Mainnet Deployment
1. Configure your `.env` file with appropriate network credentials
2. Run `truffle migrate --network [network_name]`
3. Verify contracts on Etherscan (optional but recommended)

## Usage Examples

### Registering Playground Equipment

```javascript
// Connect to the equipment registration contract
const equipmentContract = await EquipmentRegistration.deployed();

// Register new playground equipment
await equipmentContract.registerEquipment(
  "Swing Set Model XYZ-100",
  manufacturerId,
  "QmW2WQi7j...",  // IPFS hash of equipment specifications
  installationDate,
  "QmR5Tf3k...",  // IPFS hash of installation certification
  { from: playgroundOwnerAddress }
);
```

### Scheduling an Inspection

```javascript
// Connect to the inspection scheduling contract
const inspectionContract = await InspectionScheduling.deployed();

// Schedule a new inspection
await inspectionContract.scheduleInspection(
  equipmentId,
  inspectionDate,
  inspectorId,
  inspectionTypeId,
  { from: playgroundOwnerAddress }
);
```

### Recording Maintenance

```javascript
// Connect to the maintenance tracking contract
const maintenanceContract = await MaintenanceTracking.deployed();

// Record completed maintenance
await maintenanceContract.recordMaintenance(
  equipmentId,
  maintenanceTypeId,
  "QmT2WQ...",  // IPFS hash of maintenance details
  completionDate,
  { from: maintenanceCrewAddress }
);
```

### Reporting an Incident

```javascript
// Connect to the incident reporting contract
const incidentContract = await IncidentReporting.deployed();

// Report a new incident
await incidentContract.reportIncident(
  equipmentId,
  incidentDate,
  severityLevel,
  "QmL7PQ...",  // IPFS hash of incident details
  { from: authorizedReporterAddress }
);
```

## Stakeholder Benefits

### For Playground Owners
- Comprehensive equipment history and documentation
- Automated inspection scheduling
- Clear maintenance records
- Liability protection through proper documentation
- Safety improvement insights

### For Inspectors
- Transparent qualification verification
- Streamlined inspection scheduling
- Digital documentation of findings
- Immutable record of inspection activities

### For Maintenance Crews
- Clear work orders with detailed requirements
- Verification of completed work
- Transparent history of maintenance activities
- Simplified warranty claim process

### For Parents and Community
- Transparency into playground safety status
- Confidence in regular inspections and maintenance
- Ability to report safety concerns
- Public accountability for playground owners

## Future Development

- Integration with IoT sensors for real-time equipment monitoring
- Mobile application for parents to check playground safety status
- Machine learning for predictive maintenance
- AR/VR capabilities for virtual inspections
- Integration with smart city infrastructure

## Privacy and Compliance

The system is designed with the following considerations:

- Privacy protection for incident reports involving minors
- Compliance with local playground safety regulations
- Secure storage of inspection and maintenance records
- Selective disclosure of information to authorized parties

## Contributing

We welcome contributions to the Decentralized Playground Safety Inspection project!

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Thanks to the Public Playground Safety Coalition for domain expertise
- Built with support from the Child Safety Technology Initiative
- Special thanks to the playground inspectors and maintenance professionals who provided feedback during development
