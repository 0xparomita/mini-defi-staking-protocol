const STAKING_ADDRESS = "PASTE_STAKING_ADDRESS";
const TOKEN_ADDRESS = "PASTE_TOKEN_ADDRESS";

const stakingABI = [
  "function stake(uint)",
  "function withdraw(uint)",
  "function claim()"
];

const tokenABI = [
  "function approve(address,uint)"
];

let signer;
let staking;
let token;

const statusEl = document.getElementById("status");

document.getElementById("connect").onclick = async () => {
  const provider = new ethers.BrowserProvider(window.ethereum);
  await provider.send("eth_requestAccounts", []);
  signer = await provider.getSigner();

  staking = new ethers.Contract(STAKING_ADDRESS, stakingABI, signer);
  token = new ethers.Contract(TOKEN_ADDRESS, tokenABI, signer);

  statusEl.innerText = "Connected";
};

document.getElementById("approve").onclick = async () => {
  const amt = document.getElementById("approveAmount").value;
  const tx = await token.approve(STAKING_ADDRESS, ethers.parseUnits(amt,18));
  await tx.wait();
  statusEl.innerText = "Approved";
};

document.getElementById("stake").onclick = async () => {
  const amt = document.getElementById("stakeAmount").value;
  const tx = await staking.stake(ethers.parseUnits(amt,18));
  await tx.wait();
  statusEl.innerText = "Staked";
};

document.getElementById("withdraw").onclick = async () => {
  const amt = document.getElementById("withdrawAmount").value;
  const tx = await staking.withdraw(ethers.parseUnits(amt,18));
  await tx.wait();
  statusEl.innerText = "Withdrawn";
};

document.getElementById("claim").onclick = async () => {
  const tx = await staking.claim();
  await tx.wait();
  statusEl.innerText = "Rewards claimed";
};
