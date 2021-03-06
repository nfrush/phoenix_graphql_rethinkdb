defmodule RethinkdbGraphqlRethinkdb.PostResolver do
  alias RethinkdbGraphqlRethinkdb.Repo
  alias RethinkdbGraphqlRethinkdb.Post
  import Ecto.Query

  def all(_args, _info) do
    case Repo.all(Post) do
      [] -> {:error, "No Posts found. Perhaps the database is empty?"}
      result -> {:ok, result}
    end
  end

  def findByID(%{id: id}, _info) do
    case Repo.get(Post, id) do
      nil -> {:error, "Post with id #{id} not found"}
      result -> {:ok, result}
    end
  end

  def findByUserID(%{user_id: user_id}, _info) do
    case Post |> where([p], p.user_id == ^user_id) |> Repo.all do
      [] -> {:error, "No Posts belonging to User ID '#{user_id}' found"}
      result -> {:ok, result}
    end
  end

  def findByEmail(%{email: email}, _info) do
      case RethinkdbGraphqlRethinkdb.UserResolver.findByEmail(%{email: email}, "Resolving for post lookup") do
        {:error, msg} -> {:error, msg}
        {:ok, user} -> {:ok, Post |> where([p], p.user_id == ^user.id) |> Repo.all}
      end
  end

  def findByUsername(%{username: username}, _info) do
      case RethinkdbGraphqlRethinkdb.UserResolver.findByUsername(%{username: username}, "Resolving for post lookup") do
        {:error, msg} -> {:error, msg}
        {:ok, user} -> {:ok, Post |> where([p], p.user_id == ^user.id) |> Repo.all}
      end
  end
end
