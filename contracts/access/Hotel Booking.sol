// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HotelBooking {
    struct Booking {
        address guest;
        uint256 roomId;
        uint256 checkInDate;
        uint256 checkOutDate;
    }

    mapping(uint256 => Booking) public bookings;
    uint256 public nextBookingId;

    event BookingCreated(uint256 bookingId, address guest, uint256 roomId, uint256 checkInDate, uint256 checkOutDate);

    function bookRoom(uint256 roomId, uint256 checkInDate, uint256 checkOutDate) public {
        require(checkInDate < checkOutDate, "Invalid add items and check-out ");
        require(bookings[nextBookingId].guest == address(0), "Booking already exists for the given ID");

        Booking memory newBooking = Booking(msg.sender, roomId, checkInDate, checkOutDate);
        bookings[nextBookingId] = newBooking;

        emit BookingCreated(nextBookingId, msg.sender, roomId, checkInDate, checkOutDate);

        nextBookingId++;
    }

    function getBooking(uint256 bookingId) public view returns (address guest, uint256 roomId, uint256 checkInDate, uint256 checkOutDate) {
        require(bookingId < nextBookingId, "Booking does not exist for the given ID");

        Booking memory booking = bookings[bookingId];
        return (booking.guest, booking.roomId, booking.checkInDate, booking.checkOutDate);
    }
}
