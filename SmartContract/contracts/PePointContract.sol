pragma solidity ^0.4.17;

contract PePointContract {
    struct UserInfo {
        bytes32 pubKey;
        bool isCustomer;
    }

    struct PointInfo {
        bytes32 pointCustomer;
        bytes32 pointRetailer;

        //we can add hash of score to verify from customer and retailer
        //retailer hash point before encrypt => customer decrypt the point, 
        //=> hash the point and compare with the hash of retailer
        bytes32 pointHashRetailer;
    }

    struct CustomerPointInfo {
        mapping (address => PointInfo) mPointCustomer;
    }

    mapping(address => UserInfo) private mUserInfoManager;

    mapping(address => CustomerPointInfo) mRetailerManagerPoint;

    function PePointContract() {
        
    }


    //creater user (customer and retailer) with public key
    function createUser (bytes32 _pubKey, bool _isCustomer) {
        //save user info to mapping
        mUserInfoManager[msg.sender] = UserInfo(_pubKey, _isCustomer);
    }

    //get public key of a user
    //retailer can get
    function getPublicKeyUser (address _addressUser) returns (bytes32) {
        return mUserInfoManager[_addressUser].pubKey;
    }

    //retailer update the customer point 
    function updateScoreToCustomer (address _addressCustomer, bytes32 _totalScoreEncryptCusPubKey, 
                                    bytes32 _totalScoreEncryptRetPubKey, bytes32 _scoreChangeEncCusPubkey,
                                    bytes32 _scoreChangeEncRetPubkey, bytes32 _hashPoint) {
        CustomerPointInfo storage customerPointData = mRetailerManagerPoint[msg.sender];
        customerPointData.mPointCustomer[_addressCustomer].pointCustomer = _totalScoreEncryptCusPubKey;
        customerPointData.mPointCustomer[_addressCustomer].pointRetailer = _totalScoreEncryptRetPubKey;
        customerPointData.mPointCustomer[_addressCustomer].pointHashRetailer = _hashPoint;
    }

    //Retailer get the current point of user
    function getScoreCustomerFromRetailer (address _addressCustomer) returns (bytes32) {
        return mRetailerManagerPoint[msg.sender].mPointCustomer[_addressCustomer].pointRetailer;
    }

    //Customer check their point
    function getScoreCustomerFromCustomer (address _addressRetailer) returns (bytes32, bytes32) {
        return (mRetailerManagerPoint[_addressRetailer].mPointCustomer[msg.sender].pointCustomer,
                mRetailerManagerPoint[_addressRetailer].mPointCustomer[msg.sender].pointHashRetailer);
    }

}