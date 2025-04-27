# Polkafi

## About the Project
We are building a decentralized gap financing platform that enables real-world businesses — including real estate developers, SMEs, startups, and contract holders — to raise capital from retail and institutional investors globally.

Borrowers can raise funds through two options:
- Debt Financing (stable interest payments)
- Tokenized Equity Offerings (ownership upside)

Powered by Polkadot's cross-chain capabilities, our platform ensures capital aggregation from multiple blockchains, payout in stablecoins, and transparent, milestone-based fund disbursements.

## How It Works
- Borrowers request funding via debt or tokenized equity.
- Investors fund projects using assets from multiple chains.
- Platform aggregates funds into stablecoins (USDC, aUSD).
- Smart contracts manage milestone disbursements, interest repayments, and equity distributions.

## Smart Contract Overview
- Intended to use Polkadot Asset Hub
- Key Functions:
  - fundProject(): Investors fund the borrower's project.
  - payoutBorrower(): Funds released to borrowers upon milestone completion.
  - repayLoan(): Borrower repays principal + interest.
  - claimInterest(): Investors claim interest payouts.

- Deployed on Polkadot Asset Hub
- Block Explorer link: *[Insert Block Explorer Link Here]*

## Frontend Overview
- Built using *React.js*
- Wallet integration: *Polkadot.js Wallet* and *Metamask* (for EVM assets)
- Displays available projects, investment flows, borrower status, and repayment dashboards.

## Demo Video
*[Insert Demo Video Link Here]*

## UI Screenshots
| Page                         | Screenshot |
|-------------------------------|------------|
| Investor Dashboard           | ![Investor Dashboard](readme-assets/investor_dashboard.png) |
| Borrower Application Portal  | ![Borrower Portal](readme-assets/borrower_portal.png) |
| Milestone Tracking Interface | ![Milestone Tracker](readme-assets/milestone_tracker.png) |

## Repo Structure
