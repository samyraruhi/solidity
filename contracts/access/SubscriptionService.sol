// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SubscriptionService {
    struct Subscription {
        uint256 id;
        address subscriber;
        address service;
        uint256 fee;
        uint256 nextPayment;
        bool active;
    }
    
    uint256 private nextSubscriptionId;
    mapping(uint256 => Subscription) private subscriptions;
    
    event NewSubscription(uint256 indexed subscriptionId, address indexed subscriber, address indexed service, uint256 fee);
    event SubscriptionCancelled(uint256 indexed subscriptionId);
    event PaymentReceived(uint256 indexed subscriptionId, uint256 amount);
    event ServiceAccessGranted(address indexed subscriber, address indexed service);
    
    constructor() {
        nextSubscriptionId = 1;
    }
    
    function subscribe(address _service) public payable {
        require(msg.value > 0, "Fee must be greater than zero");
        
        subscriptions[nextSubscriptionId] = Subscription({
            id: nextSubscriptionId,
            subscriber: msg.sender,
            service: _service,
            fee: msg.value,
            nextPayment: block.timestamp + 30 days,
            active: true
        });
        
        emit NewSubscription(nextSubscriptionId, msg.sender, _service, msg.value);
        
        nextSubscriptionId++;
    }
    
    function cancelSubscription(uint256 _subscriptionId) public {
        Subscription storage subscription = subscriptions[_subscriptionId];
        require(subscription.subscriber == msg.sender, "You are not the subscriber");
        require(subscription.active, "Subscription is already cancelled");
        
        subscription.active = false;
        
        emit SubscriptionCancelled(_subscriptionId);
    }
    
    function processPayment(uint256 _subscriptionId) public payable {
        Subscription storage subscription = subscriptions[_subscriptionId];
        require(subscription.active, "Subscription is not active");
        require(msg.value >= subscription.fee, "Insufficient payment amount");
        
        subscription.nextPayment = block.timestamp + 30 days;
        
        emit PaymentReceived(_subscriptionId, msg.value);
    }
    
    function grantServiceAccess(address _subscriber, address _service) public {
        require(msg.sender == _service, "You are not the service provider");
        
        emit ServiceAccessGranted(_subscriber, _service);
    }
    
    function getSubscription(uint256 _subscriptionId) public view returns (Subscription memory) {
        return subscriptions[_subscriptionId];
    }
}
