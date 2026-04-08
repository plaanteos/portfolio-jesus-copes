create table if not exists public.portfolio_like_events (
  id bigint generated always as identity primary key,
  portfolio_slug text not null,
  visitor_id text not null,
  page_url text,
  created_at timestamptz not null default timezone('utc', now())
);

create unique index if not exists portfolio_like_events_unique_visitor
  on public.portfolio_like_events (portfolio_slug, visitor_id);

create index if not exists portfolio_like_events_slug_created_at_idx
  on public.portfolio_like_events (portfolio_slug, created_at desc);

alter table public.portfolio_like_events enable row level security;

drop policy if exists "public can read likes" on public.portfolio_like_events;
create policy "public can read likes"
  on public.portfolio_like_events
  for select
  to anon, authenticated
  using (true);

drop policy if exists "public can insert likes" on public.portfolio_like_events;
create policy "public can insert likes"
  on public.portfolio_like_events
  for insert
  to anon, authenticated
  with check (true);

comment on table public.portfolio_like_events is 'Log de likes del portfolio publico de Jesus Copes.';