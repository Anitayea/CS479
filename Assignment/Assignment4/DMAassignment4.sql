--Q1
--Bangalore
select BillingCity from invoices group by BillingCity order by count(*) limit 1;

--Q2
--Puja Srivastava, 36
select customers.FirstName, customers.LastName, count(*) from customers
inner join invoices i on customers.CustomerId = i.CustomerId
inner join invoice_items ii on i.InvoiceId = ii.InvoiceId
group by customers.CustomerId order by count(*) asc limit 1;

--Q3
-- 26,27,141,241
select distinct albums.AlbumId, albums.Title from tracks
inner join albums on tracks.AlbumId = albums.AlbumId
inner join genres g on tracks.GenreId = g.GenreId
where g.Name = 'Reggae';

--Q4
-- 9
select count(*) as comedyTotalPurchased from invoices as i
inner join invoice_items ii on i.InvoiceId = ii.InvoiceId
inner join tracks t on t.TrackId = ii.TrackId
inner join genres g on t.GenreId = g.GenreId
where g.Name='Comedy';

--Q5
-- Alexandre Rocha and Roberto Almeida
select customers.FirstName, customers.LastName, count(*) as latin_purchases from customers
inner join invoices i on customers.CustomerId = i.CustomerId
inner join invoice_items ii on i.InvoiceId = ii.InvoiceId
inner join tracks t on t.TrackId = ii.TrackId
inner join genres g on t.GenreId = g.GenreId
where g.Name='Latin' group by customers.CustomerId order by latin_purchases desc limit 2;

--Q6
-- Adios nonino
select t.Name from tracks as t
inner join playlist_track pt on t.TrackId = pt.TrackId
inner join playlists p on p.PlaylistId = pt.PlaylistId
where p.Name='Classical 101 - Deep Cuts' order by t.Name limit 4,1;

--Q7
-- 14
select count(*) from(
select count(*) from albums a
inner join tracks t on a.AlbumId = t.AlbumId
inner join invoice_items ii on t.TrackId = ii.TrackId
inner join invoices i on ii.InvoiceId = i.InvoiceId
group by a.AlbumId having sum(t.UnitPrice)>15 and sum(t.UnitPrice)<20);

--Q8
-- Johnson Steve
select employees.EmployeeId, employees.LastName, employees.FirstName as customer_count from employees
inner join customers c on employees.EmployeeId = c.SupportRepId
group by employees.EmployeeId order by count(*) asc limit 1;

--Q9
-- Jazz, Blues, TV Shows, Drama
select genres.Name from genres
inner join tracks t on genres.GenreId = t.GenreId
inner join invoice_items ii on t.TrackId = ii.TrackId
group by genres.GenreId having sum(ii.UnitPrice * ii.Quantity) between 50 and 100;

--Q10
-- list of 14 artists
select artists.Name from artists
inner join albums a on artists.ArtistId = a.ArtistId
group by artists.ArtistId having count(AlbumId)=3;

-- 14 in total
select count(*) from(
select artists.Name from artists
inner join albums a on artists.ArtistId = a.ArtistId
group by artists.ArtistId having count(AlbumId)=3);

--Q11
-- Confusion
select tracks.Name from tracks
inner join albums a on tracks.AlbumId = a.AlbumId
where a.Title = 'Facelift' order by tracks.Name asc limit 1,1;

--Q12
-- 204
select count(*) from(
select count(distinct artists.ArtistId) from artists
inner join albums a on artists.ArtistId = a.ArtistId
group by artists.ArtistId having count(AlbumId)>=1);

--or simply
select count(distinct ArtistId) from albums;


--Q13
-- Heroes, Season 1
select Title from albums
inner join tracks t on albums.AlbumId = t.AlbumId
group by albums.AlbumId order by sum(t.Milliseconds) desc limit 4,1;

--Q14
-- Berlin, London, Mountain View, Paris, Prague, Sao Paulo
select BillingCity from invoices
group by BillingCity having count(distinct BillingPostalCode) > 1;
