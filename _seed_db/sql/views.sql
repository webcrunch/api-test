CREATE VIEW TABLES_AND_VIEWS AS 
	SELECT TABLE_NAME AS name,
	REPLACE (LOWER(TABLE_TYPE), "base ", "") AS type
	FROM
	    information_schema.tables
	WHERE table_schema = (
	        SELECT
	            DATABASE() as db
	    );
; 

;

;

;

CREATE VIEW SEATS_PER_AUDITORIUM AS 
	SELECT
	    auditoriums.*,
	    COUNT(seats.id) AS numberOfSeats
	FROM auditoriums, seats
	WHERE
	    seats.auditoriumId = auditoriums.id
	GROUP BY auditoriums.i
ID; 

CREATE VIEW MOVIES_BY_CATEGORY AS 
	SELECT
	    categories.title AS category,
	    movies.title AS movie
	FROM
	    categories,
	    movies,
	    moviesxcategories
	WHERE
	    movies.id = moviesxcategories.movieId && categories.id = moviesxcategories.c
CATEGORYID; 

CREATE VIEW SCREENINGS_OVERVIEW AS 
	SELECT
	    screenings.id AS screeningId,
	    screenings.time AS screeningTime,
	    movies.title AS movie,
	    auditoriums.name AS auditorium
	FROM
	    screenings,
	    movies,
	    auditoriums
	WHERE
	    movieId = movies.id && auditoriumId = auditoriums.id
	ORDER BY screenings.i
ID; 

CREATE VIEW BOOKINGS_OVERVIEW AS 
	SELECT
	    users.email,
	    bookings.bookingNumber,
	    GROUP_CONCAT(
	        seats.seatNumber
	        ORDER BY
	            seats.seatNumber SEPARATOR ", "
	    ) AS seats,
	    GROUP_CONCAT(
	        ticketTypes.name
	        ORDER BY
	            ticketTypes.name SEPARATOR ", "
	    ) AS ticketTypes,
	    screenings_overview.*
	FROM
	    bookings,
	    users,
	    bookingsxseats,
	    screenings_overview,
	    tickettypes,
	    seats
	WHERE
	    bookings.screeningId = screenings_overview.screeningId && bookings.userId = users.id && bookingsXseats.bookingId = bookings.id && seats.id = bookingsXseats.seatId && ticketTypes.id = bookingsXseats.ticketTypeId
	GROUP BY
BOOKINGID; 

CREATE VIEW OCCUPIED_SEATS AS 
	SELECT
	    screenings_overview.*,
	    GROUP_CONCAT(
	        seats.seatNumber
	        ORDER BY
	            seats.seatNumber SEPARATOR ", "
	    ) AS occupiedSeats,
	    COUNT(seats.seatNumber) AS occupied,
	    seats_per_auditorium.numberOfSeats AS total,
	    ROUND(
	        100 * COUNT(seats.seatNumber) / seats_per_auditorium.numberOfSeats
	    ) AS occupiedPercent
	FROM
	    screenings_overview,
	    seats,
	    bookingsXseats,
	    bookings,
	    seats_per_auditorium
	WHERE
	    seats.id = bookingsxseats.seatId && bookings.id = bookingsxseats.bookingId && bookings.screeningId = screenings_overview.screeningId && seats_per_auditorium.name = screenings_overview.auditorium
	GROUP BY
	    screenings_overview.s
SCREENINGID; 

CREATE VIEW TOTALS AS 
	SELECT
	    ticketTypes.name,
	    COUNT(*) AS totalPeople,
	    SUM(ticketTypes.price) AS totalSales
	FROM
	    bookingsXseats,
	    ticketTypes
	WHERE
	    bookingsXseats.ticketTypeId = ticketTypes.id
	GROUP BY ticketTypes.id
	UNION
	SELECT
	    'TOTALS',
	    COUNT(*),
	    SUM(ticketTypes.price)
	FROM
	    bookingsXseats,
	    ticketTypes
	WHERE
	    bookingsXseats.ticketTypeId = ticketTypes.id
