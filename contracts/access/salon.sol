// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract salonBooking{
     enum AppointmentStatus { Available, Booked }//define two possible states
     struct Appointment {
       address customer;
       uint256 timestamp;
       AppointmentStatus status; 
    }
    mapping(uint256 =>Appointment) public appointments;
    event  AppointmentBooked(uint256 indexed timestamp,address indexed customer);
    event  AppointmentCancelled(uint256 indexed timestamp,address indexed customer);
    function BookAppointment(uint256 timestamp)external {
 require(appointments[timestamp].status == AppointmentStatus.Available, "Appointment already booked");
appointments[timestamp]=Appointment(msg.sender,timestamp,AppointmentStatus.Booked);
emit AppointmentBooked(timestamp,msg.sender);
    }
function CancelAppointment(uint256 timestamp)external {
     require(appointments[timestamp].status == AppointmentStatus.Booked, "No booking found");
     delete appointments[timestamp];
emit AppointmentCancelled(timestamp,msg.sender);

}
function getAppointmentStatus(uint256 timestamp)external view returns(AppointmentStatus){
    return appointments[timestamp].status;
}

}
