pragma solidity 0.7.5;
//pragma abicoder_v2;

//import "./Ownable.sol";

contract MultiSigWallet {
    
    address payable public owner;
    address[] public addressesToSign;
    uint approvalsLimit;
    
    struct Transfer{
        address payable _to;
        uint _amount;
        uint _txId;
        address[] _signatures;
    }
    
    //mapping(address=>mapping(uint=>bool)) approvals;
    address[] signature;
    Transfer[] public transactionLog;

    constructor(address[] memory addresses, uint nrOfApprovals){ // format for deploying: ["0x5B38Da6a701c568545dCfcB03FcB875f56beddC4","0x5B38Da6a701c568545dCfcB03FcB875f56beddC4","0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c"]
        owner = msg.sender;
        require(addresses.length >= nrOfApprovals);
        for(uint i=0; i<addresses.length; i++)
        {
            addressesToSign.push(addresses[i]);
        }
        approvalsLimit = nrOfApprovals;
    }
    
    event depositDone(uint amount, address indexed depositedTo); //indexed (used for search and query)
    
    function deposit() public payable returns (uint){ //paybale allows to use msg.value
        emit depositDone(msg.value, msg.sender);
        return address(this).balance; // contract reflects the address
    }
    
    function removeTransaction(uint txId) private{
        for(uint i = txId; i < transactionLog.length - 1; i++){
            transactionLog[i] = transactionLog[i + 1];
        }
        transactionLog.pop();
    }
    
    function withdraw(uint txId) public payable returns (uint){
        //msg.sender is a payable address
        /* 
        address payable toSend = 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
        toSend.transfer(amount); */
        require(txId <= transactionLog.length);
        address payable toSend = transactionLog[txId]._to;
        require(address(this).balance >= transactionLog[txId]._amount, "You do not have enough funds");
        require(approvalsLimit <= transactionLog[txId]._signatures.length, "You do not have enough signatures");
        removeTransaction(txId);
        toSend.transfer(transactionLog[txId]._amount); // the safest way to withdraw because of built error handlings (revert commend as for required)
        return address(this).balance;
    }
    
    function getBalance() public view returns (uint){
        return address(this).balance; // contract reflects the address
    }
    
    function addTransaction(address payable _to, uint _amount) external payable{
        bool approveAllowed = false;
        for(uint i; i <= addressesToSign.length; i++) {
            if(msg.sender == addressesToSign[i]) {
                approveAllowed = true;
                break;
            }
        }
        require(approveAllowed == true, "You are not allowed to sign this transaction or you already signed it");
        if(approveAllowed) {
            transactionLog.push(Transfer(_to, _amount, transactionLog.length, signature));
        }
    }

    function approve(uint txId) public {
        bool approveAllowed = false;
        for(uint i; i <= addressesToSign.length; i++) {
            for(uint j; j < transactionLog[txId]._signatures.length; j++){
                if(msg.sender == transactionLog[txId]._signatures[j]){
                    approveAllowed = false;
                    break;
                }
            }

            if(msg.sender == addressesToSign[i]) {
                approveAllowed = true;
                break;
            }
        }
        require(approveAllowed == true, "You are not allowed to sign this transaction or you already signed it");
        if(approveAllowed) {
            transactionLog[txId]._signatures.push(msg.sender);
        }
    }
}