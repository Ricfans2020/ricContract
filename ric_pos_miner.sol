


pragma solidity >=0.4.26 <0.7.0;
pragma experimental ABIEncoderV2;

library SafeMath {
    
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
       
        uint256 c = a * b;
        assert(a == 0 || c / a == b);
        return c;

    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
       
        assert(b <= a);
        return a - b;

    }

    function add(uint256 a, uint256 b) internal pure returns (uint256) {
       
        uint256 c = a + b;
        assert(c >= a);
        return c;

    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
       
        require(b > 0);
        uint256 c = a / b;
        return c;

    }

}

contract Ownable {
    
    address public owner;
  
    constructor() public {

        owner = msg.sender;

    }
   
    modifier onlyOwner() {

        require(msg.sender == owner);
        _;

    }

    function transferOwnership(address newOwner) onlyOwner public {
        
        if (newOwner != address(0)) {
            owner = newOwner;
        }

    }

}


interface RicToken{
    function balanceOf(address owner) external view returns (uint256);
    function transfer(address to, uint256 value) external returns (bool);
    function transferFrom(address from, address to, uint256 value) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
}


contract PosRic is Ownable{

    using SafeMath for uint256;

    
    RicToken rictoken = RicToken(0xbc52dDa0312BF75Dd4018FDd54Cb903f221B534d);

    
    struct Proposal {
        string name;    
        address target; 
        uint voteCount; 
        uint cancelVoteCount; 
        address[] permission; 
        bool flag; 
    }

    
    struct Voter {
        uint weight;  
        bool voted;    
        address delegate;  
        uint vote;     
        mapping(uint=>uint) amount; 
    }

    
    struct Good {
        uint power; 
    }

    
    struct CancelVote {
       address cancelVote;  
       uint value; 
    }

    
    mapping(address => Voter) public voters;

    
    mapping(address=>Good) public good;

    
    mapping(address=>CancelVote) public cancelVote;

   
    Proposal[] public proposals;

    
    address[] public alternativePeople;

    
    address[] public frozenSuperPoints;

    
    address[] public cancelVoteAmount;

    
    address[] rank;

    
    address[] public commonPeopleAmount;

    
    uint commonPower;

    
    uint allNetPower;

    
    uint eachPeoplePower;

    
    event FrozenFunds(address target, bool frozen);

    
    constructor(string[] memory proposalNames,address[] memory targets) public {      
        for (uint i = 0; i <proposalNames.length && i<targets.length; i++) {
            proposals.push(Proposal({
                name: proposalNames[i],
                target:targets[i],
                voteCount: 0,
                cancelVoteCount:0,
                permission:new address[](10),
                flag:false
            }));
        }
    }

    
    function vote(uint proposal,uint amount,address[] memory targets) public {
        Voter storage sender = voters[msg.sender];
        require(sender.weight != 0, "Has no right to vote");
        require(!sender.voted, "Already voted.");
        uint _ricTokenAllowance = rictoken.allowance(msg.sender, address(this));
        require(_ricTokenAllowance >= amount.mul(10**6));
        require(proposals[proposal].flag != true);
        rictoken.transferFrom(msg.sender,proposals[proposal].target,amount.mul(10**6));
        sender.voted = true;
        sender.vote = proposal;

        proposals[proposal].voteCount += amount;
        userPower(proposal,targets,msg.sender);
    
    }

    
    function getVotes(uint proposal)public view returns(uint){

        return proposals[proposal].voteCount;

    }

   
    function getCancelVotes(uint proposal)public view returns(uint){

        return proposals[proposal].cancelVoteCount;

    }

    
    function sort() public {

        for(uint i = 0;i< proposals.length-1;i++){
            for(uint j = 0;j< proposals.length-i-1;j++){
                if(proposals[j].voteCount < proposals[j+1].voteCount){// 相邻元素两两对比
                     Proposal storage hand =  proposals[j];
                     proposals[j] = proposals[j+1];
                     proposals[j+1] = hand;               
                }
            }
        }
    
        for(uint p = 0; p<proposals.length;p++){

            rank.push(proposals[p].target);

        }

    }

    
    function getRank() public view returns(address[] memory){

        return rank;

    }


    
    function getPointPower(address _target) public view returns(uint){

        uint power;
        
        for(uint i = 0 ; i<proposals.length;i++){

            if(proposals[i].target == _target){

                if(i == 1){

                    power+=(good[_target].power.add(10000));

                }
                

            }else if(proposals[i].target == _target){

                if( i == 2){

                    power+=(good[_target].power.add(5000));

                }
                if( i == 3){

                    power+=(good[_target].power.add(5000));

                }
                if( i == 4){

                    power+=(good[_target].power.add(5000));

                }
                if( i == 5){

                    power+=(good[_target].power.add(5000));

                }
                if( i == 6){

                    power+=(good[_target].power.add(5000));

                }
                if( i == 7){

                    power+=(good[_target].power.add(5000));

                }
                if( i == 8){

                    power+=(good[_target].power.add(5000));

                }
                if( i == 9){

                    power+=(good[_target].power.add(5000));

                }
                if( i == 10){

                    power+=(good[_target].power.add(5000));

                }
                if( i == 11){

                    power+=(good[_target].power.add(5000));

                }

            }else if(proposals[i].target == _target){

                if( i == 12){

                    power+=(good[_target].power.add(1000));

                }
                 if( i == 13){

                    power+=(good[_target].power.add(1000));

                }
                 if( i == 14){

                    power+=(good[_target].power.add(1000));

                }
                 if( i == 15){

                    power+=(good[_target].power.add(1000));

                }
                 if( i == 16){

                    power+=(good[_target].power.add(1000));

                }
                if( i == 17){

                    power+=(good[_target].power.add(1000));

                }
                 if( i == 18){

                    power+=(good[_target].power.add(1000));

                }
                 if( i == 19){

                    power+=(good[_target].power.add(1000));

                }
                 if( i == 20){

                    power+=(good[_target].power.add(1000));

                }
                 if( i == 21){

                    power+=(good[_target].power.add(1000));

                }
                if( i == 22){

                    power+=(good[_target].power.add(1000));

                }
                 if( i == 23){

                    power+=(good[_target].power.add(1000));

                }
                 if( i == 24){

                    power+=(good[_target].power.add(1000));

                }
                 if( i == 25){

                    power+=(good[_target].power.add(1000));

                }
                 if( i == 26){

                    power+=(good[_target].power.add(1000));

                }
                if( i == 27){

                    power+=(good[_target].power.add(1000));

                }
                 if( i == 28){

                    power+=(good[_target].power.add(1000));

                }
                 if( i == 29){

                    power+=(good[_target].power.add(1000));

                }
                 if( i == 30){

                    power+=(good[_target].power.add(1000));

                }
                 if( i == 31){

                    power+=(good[_target].power.add(1000));

                }


            }else{

                power+=(good[_target].power.add(500));
            }

        }
        return power;

    }


    
    function getWitnessPower(address user) public view returns(uint){

        uint power;
        for(uint i = 0 ; i<alternativePeople.length;i++){

            if(alternativePeople[i] == user){

                power += good[user].power.add(100);

            }else{

                power += good[user].power;

            }
        }
        return power;
    }

    function userPower(uint proposal,address[] memory targets,address user)public{

      
       require(voters[user].voted == true);
       
       
       for(uint i = 0 ;i<alternativePeople.length;i++){
        
        
        if(alternativePeople[i] != user){

            
            for(uint k =0 ;k<targets.length;k++){
                
                if(targets[k] != user){

                     
                     if(voters[user].voted == false){

                        return;

                     }else{

                        
                        eachPeoplePower = voters[user].amount[proposal].mul(100);
                        commonPower += eachPeoplePower;
                        commonPeopleAmount.push(user);

                     }

                }
            }

        }

       }

    }

    
    function getPersonPower(uint proposal,address user)public view returns(uint){

        for(uint i = 0 ;i<commonPeopleAmount.length;i++){

            if(commonPeopleAmount[i] == user){

               return voters[user].amount[proposal].mul(100); 

            }

              return 0;
            

        }
        

    }


    
    function allPower(uint proposal,address[] memory targets) public{

        uint totalPower;
        for(uint i = 0 ; i<alternativePeople.length;i++){

            totalPower+=getWitnessPower(alternativePeople[i]);

        }

        uint superPower;
        for(uint p = 0 ; p<targets.length;p++){
         
         superPower+=getPointPower(targets[p]);

        }

        allNetPower = commonPower+totalPower+superPower;

    }

    
    function getAllPower()public view returns(uint){

        return allNetPower;

    }

    function alternative(uint proposal,address[] memory targets,address[] memory witness)public returns(address[] memory){

        if(proposals[proposal].target == msg.sender){

            for(uint k = 0; k<witness.length;k++){

                alternativePeople.push(witness[k]);

            }
        }

        address user = address(msg.sender);
        userPower(proposal,targets,user);
       
    }

    function getAlternative()public view returns(address[] memory){

        return alternativePeople;

    }


    function frozen(uint proposal,bool freeze)public {

        proposals[proposal].flag = freeze;
        emit FrozenFunds(proposals[proposal].target, freeze);
        proposals[proposal].cancelVoteCount = 0;
        frozenSuperPoints.push(proposals[proposal].target);

    }

    function frozePoints()public view returns(address[] memory){

      return frozenSuperPoints;

    }


    function fetchThaw(uint proposal,bool freeze)public {

        if(proposals[proposal].target != msg.sender){
          
            return;

        }else{

            if(proposals[proposal].flag == freeze){
                
                proposals[proposal].flag =!freeze;

            }
            proposals[proposal].flag = freeze;

        }

    }

    function voteThaw(uint proposal,uint amount)public{

        for(uint i = 0; i<proposals.length;i++){

            require(proposals[proposal].target != msg.sender);

            for(uint p = 0; p<alternativePeople.length;p++){

                require(msg.sender == alternativePeople[p] || proposals[p].target != msg.sender); 

                Voter storage sender = voters[msg.sender];
                require(sender.weight != 0, "Has no right to vote");
                uint _ricTokenAllowance = rictoken.allowance(msg.sender, address(this));
                require(_ricTokenAllowance >= amount.mul(10**6));
                require(proposals[proposal].flag == true);
                rictoken.transferFrom(msg.sender,proposals[proposal].target,amount.mul(10**6));
                sender.voted = true;
                sender.vote = proposal;

                cancelVote[msg.sender].cancelVote = msg.sender;
                cancelVote[msg.sender].value = amount;
                cancelVoteAmount.push(cancelVote[msg.sender].cancelVote);
                proposals[proposal].cancelVoteCount += amount;

            }


        }

    }


    function thaw(uint proposal)public returns(address[] memory){

        require(msg.sender == owner);

        if(proposals[proposal].cancelVoteCount > proposals[proposal].voteCount.div(2)){

            proposals[proposal].flag = false;
            return rank;   

        }else{

            proposals[proposal].cancelVoteCount = 0;
            proposals[proposal].voteCount = 0;

            require(rictoken.balanceOf(proposals[proposal].target) > 0);

            for(uint i = 0;i<cancelVoteAmount.length;i++){

                require(proposals[proposal].flag == true);
                rictoken.transferFrom(proposals[proposal].target,cancelVote[cancelVoteAmount[i]].cancelVote,cancelVote[cancelVoteAmount[i]].value.mul(10**6));

            }

            proposals[proposal].cancelVoteCount = 0;
            proposals[proposal].voteCount = 0;
            proposals[proposal].permission = new address[](0);
            delete proposals[proposal];

            for(uint p = 0;p<proposals.length-1;p++){
                for(uint j=0;j< proposals.length-p-1;j++){
                    if(proposals[j].voteCount < proposals[j+1].voteCount){// 相邻元素两两对比
                         Proposal storage hand =  proposals[j];
                         proposals[j]= proposals[j+1];
                         proposals[j+1]=hand;               
                    }
                }
            }
            
            rank = new address[](0);
            for(uint k = 0;k<proposals.length;k++){

                rank.push(proposals[k].target);

            }
            return rank;

        }

    }


    function calcleSupperPoints(uint proposal,uint amount,bool freeze) public {

        for(uint i = 0 ; i<alternativePeople.length;i++){

            if(msg.sender != alternativePeople[i]){
              
              return;

            }else{

                if(proposals[proposal].flag != true){

                    Voter storage sender = voters[msg.sender];
                    require(sender.weight != 0, "Has no right to vote");
                    rictoken.allowance(msg.sender, address(this));
                    rictoken.transferFrom(msg.sender,proposals[proposal].target,amount.mul(10**6));
                    sender.voted = true;
                    sender.vote = proposal;

                    proposals[proposal].cancelVoteCount += amount;

                    if(proposals[proposal].cancelVoteCount > (proposals[proposal].voteCount.mul(2)).div(3)){

                        frozen(proposal,freeze);

                    }

                 
                }
                
            }

        }

    }


}











