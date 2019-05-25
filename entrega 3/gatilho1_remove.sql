.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;

DROP TRIGGER IF EXISTS updateStockLojaAluguer;
DROP TRIGGER IF EXISTS removeStockLojaAluguer;
DROP TRIGGER IF EXISTS checkStockLojaAluguer;