// SPDX-License-Identifier: MIT
// Version of Solidity compiler this program was written for
pragma solidity ^0.8.0;
contract proj{
    // requests  
    uint count=0;
    struct req{
        string order;
        string requested_unit;
        string[] status;
        string accepted_by;
    }
    mapping(uint => req)requests;
    // ADST
    struct adst{
        string div_id;
        uint[] req_ids;
    }
    mapping(string=>adst)ADST;

    // DDST
    struct ddst{
        string[] adst_ids;
        uint[] all_req_ids;
        uint[] req_to_units;
    }
    mapping (string =>ddst)DDST;

    // login
    function login()public{
        ADST["unit_00"].div_id="dg_0";
        ADST["unit_01"].div_id="dg_0";
        ADST["unit_10"].div_id="dg_1";
        ADST["unit_11"].div_id="dg_1";
    }

    // adst raises the request   
    function raise_req(string memory unit_id,string memory ord)public{
        requests[count].order=ord;
        ADST[unit_id].req_ids.push(count);
        string memory id=ADST[unit_id].div_id;
        DDST[id].all_req_ids.push(count);
        requests[count++].requested_unit=unit_id;
    }

    // ddst views the request
    function get_req(string memory div_id) public view  returns (string[] memory,string[] memory) {
        uint n=DDST[div_id].all_req_ids.length;
        uint[] memory arr=DDST[div_id].all_req_ids;
        string[] memory temp_array=new string[](n);
        string[] memory new_array=new string[](n);
        for(uint i=0;i<n;i++){
            temp_array[i]=requests[arr[i]].order;
            new_array[i]=requests[arr[i]].requested_unit;
        }
        return (temp_array,new_array);
    }

    // ask other units
    function forward_to_unit(uint req_no,string memory div_id,string memory )public{
        DDST[div_id].req_to_units.push(req_no);
    }
    
    // 
    uint[] production_reqs;
    function produce(uint req_no)public{
        production_reqs.push(req_no);
    }

}
