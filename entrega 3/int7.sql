.mode columns
.headers on
.nullvalue NULL

select (select count(*)
        from (select idPessoa from Cliente
              EXCEPT
              select idCliente from ClienteGold
              EXCEPT
              select idCliente from ClienteSilver)) as numClientesNormais,

        (select count(*) from ClienteGold) as numClientesGold,

        (select count(*) from ClienteSilver) as numClientesSilver;
