/**
 * Helper functions to mock Clarity blockchain functions for testing
 */

export function mockClarityBlockInfo(mockClarity) {
	// Mock the get-block-info? function
	return {
		time: (height) => {
			if (height < 0 || height >= mockClarity.blockHeight) {
				return { type: "none" }
			}
			return {
				type: "some",
				value: mockClarity.blockTime - (mockClarity.blockHeight - height) * 600, // Assuming 10 min blocks
			}
		},
	}
}

export function mockClarityBitcoin(mockClarity) {
	// Mock Bitcoin-related functions if needed
	return {}
}

