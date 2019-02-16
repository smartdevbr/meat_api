defmodule MeatApiWeb.ErrorViewTest do
  use MeatApiWeb.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "renders 404.json" do
    assert render(MeatApiWeb.ErrorView, "404.json", []) == "Not Found"
  end

  test "renders 422.json" do
    assert render(MeatApiWeb.ErrorView, "422.json", []) == "Unprocessable Entity"
  end

  test "renders 500.json" do
    assert render(MeatApiWeb.ErrorView, "500.json", []) == "Internal Server Error"
  end

  test "render any other" do
    assert render(MeatApiWeb.ErrorView, "505.json", []) == "HTTP Version Not Supported"
  end
end
