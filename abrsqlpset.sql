
CREATE TABLE clientes (
                cliente_id NUMERIC(38) NOT NULL,
                email VARCHAR(255) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                telefone1 VARCHAR(20) NOT NULL,
                telefone2 VARCHAR(20),
                telefone3 VARCHAR(20),
                CONSTRAINT clientes_id PRIMARY KEY (cliente_id)
);
COMMENT ON TABLE clientes IS 'tabela clientes';
COMMENT ON COLUMN clientes.cliente_id IS 'id cliente';
COMMENT ON COLUMN clientes.email IS 'email cliente
';
COMMENT ON COLUMN clientes.nome IS 'nome cliente';
COMMENT ON COLUMN clientes.telefone1 IS 'telefone 1 clientes';
COMMENT ON COLUMN clientes.telefone2 IS 'telefone 2 cliente';
COMMENT ON COLUMN clientes.telefone3 IS 'telefone 3 cliente';


CREATE TABLE produtos (
                produto_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                preco_unitario NUMERIC(10,2) NOT NULL,
                detalhes BYTEA NOT NULL,
                imagem BYTEA NOT NULL,
                imagem_mime_type VARCHAR(512) NOT NULL,
                imagem_arquivo VARCHAR(512) NOT NULL,
                imagem_charset VARCHAR(512) NOT NULL,
                imagem_ultima_atualizacao DATE NOT NULL,
                CONSTRAINT produto_id_pk PRIMARY KEY (produto_id)
);
COMMENT ON TABLE produtos IS 'tabela produtos';
COMMENT ON COLUMN produtos.produto_id IS 'id produto';
COMMENT ON COLUMN produtos.nome IS 'nome produto';
COMMENT ON COLUMN produtos.preco_unitario IS 'preco produtos';
COMMENT ON COLUMN produtos.detalhes IS 'detalhes produtos';
COMMENT ON COLUMN produtos.imagem IS 'imagem produtos';
COMMENT ON COLUMN produtos.imagem_mime_type IS 'tipo imagem';
COMMENT ON COLUMN produtos.imagem_arquivo IS 'arquivo imagem';
COMMENT ON COLUMN produtos.imagem_charset IS 'charset imagem';
COMMENT ON COLUMN produtos.imagem_ultima_atualizacao IS 'atualizacao imagem produto';


CREATE TABLE lojas (
                loja_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                endereco_web VARCHAR(100) NOT NULL,
                endereco_fisico VARCHAR(512) NOT NULL,
                latitude NUMERIC NOT NULL,
                longitude NUMERIC NOT NULL,
                logo BYTEA NOT NULL,
                logo_mime_type VARCHAR(512) NOT NULL,
                logo_arquivo VARCHAR(512) NOT NULL,
                logo_charset VARCHAR(512) NOT NULL,
                logo_ultima_atualizacao DATE NOT NULL,
                CONSTRAINT loja_id_pk PRIMARY KEY (loja_id)
);
COMMENT ON TABLE lojas IS 'tabela lojas';
COMMENT ON COLUMN lojas.loja_id IS 'id lojas';
COMMENT ON COLUMN lojas.nome IS 'nome lojas';
COMMENT ON COLUMN lojas.endereco_web IS 'local online';
COMMENT ON COLUMN lojas.endereco_fisico IS 'local fisico';
COMMENT ON COLUMN lojas.latitude IS 'coordenada latitude';
COMMENT ON COLUMN lojas.longitude IS 'coordenada longitude';
COMMENT ON COLUMN lojas.logo IS 'logomarca loja';
COMMENT ON COLUMN lojas.logo_mime_type IS 'tipo da logomarca';
COMMENT ON COLUMN lojas.logo_arquivo IS 'arquivo logo';
COMMENT ON COLUMN lojas.logo_charset IS 'charset logo';
COMMENT ON COLUMN lojas.logo_ultima_atualizacao IS 'atualizacao logo';


CREATE TABLE estoques (
                estoque_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                CONSTRAINT estoque_id_pk PRIMARY KEY (estoque_id)
);
COMMENT ON TABLE estoques IS 'tabela estoques';
COMMENT ON COLUMN estoques.estoque_id IS 'estoque produtos';
COMMENT ON COLUMN estoques.loja_id IS 'id loja';
COMMENT ON COLUMN estoques.produto_id IS 'id produto';
COMMENT ON COLUMN estoques.quantidade IS 'quantidade estoques';


CREATE TABLE envios (
                envio_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                endereco_entrega VARCHAR(512) NOT NULL,
                status VARCHAR(15) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                CONSTRAINT envio_id_pk PRIMARY KEY (envio_id)
);
COMMENT ON TABLE envios IS 'tabela envios';
COMMENT ON COLUMN envios.envio_id IS 'id envio';
COMMENT ON COLUMN envios.loja_id IS 'id loja';
COMMENT ON COLUMN envios.endereco_entrega IS 'local entrega';
COMMENT ON COLUMN envios.status IS 'status envio';
COMMENT ON COLUMN envios.cliente_id IS 'id cliente tabela envio';


CREATE TABLE pedidos (
                pedido_id NUMERIC(38) NOT NULL,
                data_hora TIMESTAMP NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                status VARCHAR(15) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                CONSTRAINT pedido_id_pk PRIMARY KEY (pedido_id)
);
COMMENT ON TABLE pedidos IS 'tabela pedidos';
COMMENT ON COLUMN pedidos.pedido_id IS 'id pedidos';
COMMENT ON COLUMN pedidos.data_hora IS 'tempo pedidos';
COMMENT ON COLUMN pedidos.cliente_id IS 'id cliente';
COMMENT ON COLUMN pedidos.status IS 'status pedido';
COMMENT ON COLUMN pedidos.loja_id IS 'id loja';


CREATE TABLE pedido_itens (
                pedido_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                numero_da_linha NUMERIC(38) NOT NULL,
                preco_unitario NUMERIC(10,2) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                envio_id NUMERIC(38) NOT NULL,
                CONSTRAINT pedido_itens_pk PRIMARY KEY (pedido_id, produto_id)
);
COMMENT ON TABLE pedido_itens IS 'tabela itens pedidos';
COMMENT ON COLUMN pedido_itens.pedido_id IS 'id pedido';
COMMENT ON COLUMN pedido_itens.produto_id IS 'id produto';
COMMENT ON COLUMN pedido_itens.numero_da_linha IS 'numero linha itens pedidos';
COMMENT ON COLUMN pedido_itens.preco_unitario IS 'preco itens';
COMMENT ON COLUMN pedido_itens.quantidade IS 'quantidade itens';
COMMENT ON COLUMN pedido_itens.envio_id IS 'id envio itens';


ALTER TABLE pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedido_itens ADD CONSTRAINT produtos_pedido_itens_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedido_itens ADD CONSTRAINT envios_pedido_itens_fk
FOREIGN KEY (envio_id)
REFERENCES envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedido_itens ADD CONSTRAINT pedidos_pedido_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
