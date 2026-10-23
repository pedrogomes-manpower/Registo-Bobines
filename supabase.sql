-- Executar uma vez no Supabase: SQL Editor > New query > Run

create table if not exists public.utilizadores (
  id bigint generated always as identity primary key,
  nome text not null unique
);

create table if not exists public.registos (
  id bigint generated always as identity primary key,
  codigo text not null,
  utilizador text not null,
  criado_em timestamptz not null default now()   -- data e hora definidas pelo servidor
);
create index if not exists registos_criado_em_idx on public.registos (criado_em);

alter table public.utilizadores enable row level security;
alter table public.registos enable row level security;

-- Acesso com a chave anon: ler e inserir registos (sem editar nem apagar);
-- ler, adicionar e remover utilizadores.
create policy "registos_select" on public.registos for select to anon using (true);
create policy "registos_insert" on public.registos for insert to anon with check (length(codigo) between 1 and 100);
create policy "utilizadores_select" on public.utilizadores for select to anon using (true);
create policy "utilizadores_insert" on public.utilizadores for insert to anon with check (length(nome) between 1 and 80);
create policy "utilizadores_delete" on public.utilizadores for delete to anon using (true);
