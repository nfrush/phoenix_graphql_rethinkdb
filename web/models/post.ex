defmodule RethinkdbGraphqlRethinkdb.Post do
  use RethinkdbGraphqlRethinkdb.Web, :model

  schema "posts" do
    field :title, :string
    field :body, :string
    field :published, :boolean, default: false
    field :created_at, :string
    belongs_to :user, RethinkdbGraphqlRethinkdb.User
    has_many :likes, RethinkdbGraphqlRethinkdb.Like
    has_many :comments, RethinkdbGraphqlRethinkdb.Comment

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :body, :published])
    |> validate_required([:title, :body, :published])
  end
end
