pragma solidity ^0.8.0;

contract GateOfOly {
   uint256 jackpot;
   uint256 winnings;
   uint256 randomNumber;
   address payable owner;

   constructor() public {
      owner = msg.sender;
      jackpot = 1000000000000000000;
   }

   function play(uint256 bet) public payable {
      require(msg.value == bet, "Incorrect bet amount.");
      randomNumber = uint256(keccak256(abi.encodePacked(now, msg.sender)));
      if (randomNumber % 100 < 50) {
         winnings = bet * 2;
         jackpot -= winnings;
         msg.sender.transfer(winnings);
      } else {
         jackpot += bet;
      }
   }

   function collectWinnings() public {
      require(msg.sender == address(this), "Only contract owner can collect winnings.");
      require(winnings > 0, "No winnings to collect.");
      msg.sender.transfer(winnings);
      winnings = 0;
   }

   function getRandomNumber() public view returns (uint256) {
      return randomNumber;
   }

   function getJackpot() public view returns (uint256) {
      return jackpot;
   }
}
