defmodule ReportsGeneratorTest do
  use ExUnit.Case

  describe "build/1" do
    test "builds the report" do
      file_name = "report_test.csv"

      response =
        file_name
        |> ReportsGenerator.build()

      expected_response = %{
        "foods" => %{
          "açaí" => 1,
          "churrasco" => 2,
          "esfirra" => 3,
          "hambúrguer" => 2,
          "pastel" => 0,
          "pizza" => 2,
          "prato_feito" => 0,
          "sushi" => 0
        },
        "users" => %{
          "1" => 48,
          "10" => 36,
          "11" => 0,
          "12" => 0,
          "13" => 0,
          "14" => 0,
          "15" => 0,
          "16" => 0,
          "17" => 0,
          "18" => 0,
          "19" => 0,
          "2" => 45,
          "20" => 0,
          "21" => 0,
          "22" => 0,
          "23" => 0,
          "24" => 0,
          "25" => 0,
          "26" => 0,
          "27" => 0,
          "28" => 0,
          "29" => 0,
          "3" => 31,
          "30" => 0,
          "4" => 42,
          "5" => 49,
          "6" => 18,
          "7" => 27,
          "8" => 25,
          "9" => 24
        }
      }

      assert response == expected_response
    end
  end

  describe "build_from_many/1" do
    test "when a file list is provided, builds the report" do
      file_names = ["report_test.csv", "report_test.csv"]

      response =
        file_names
        |> ReportsGenerator.build_from_many()

      expected_response =
        {:ok,
         %{
           "foods" => %{
             "açaí" => 2,
             "churrasco" => 4,
             "esfirra" => 6,
             "hambúrguer" => 4,
             "pastel" => 0,
             "pizza" => 4,
             "prato_feito" => 0,
             "sushi" => 0
           },
           "users" => %{
             "1" => 96,
             "10" => 72,
             "11" => 0,
             "12" => 0,
             "13" => 0,
             "14" => 0,
             "15" => 0,
             "16" => 0,
             "17" => 0,
             "18" => 0,
             "19" => 0,
             "2" => 90,
             "20" => 0,
             "21" => 0,
             "22" => 0,
             "23" => 0,
             "24" => 0,
             "25" => 0,
             "26" => 0,
             "27" => 0,
             "28" => 0,
             "29" => 0,
             "3" => 62,
             "30" => 0,
             "4" => 84,
             "5" => 98,
             "6" => 36,
             "7" => 54,
             "8" => 50,
             "9" => 48
           }
         }}

      assert response == expected_response
    end

    test "return error when list not provided" do
      result = ReportsGenerator.build_from_many("report_test.csv")
      expected = {:error, "provide a list of filenames"}
      assert result == expected
    end
  end

  describe "fetch_higher_cost/2" do
    test "when the option is 'users' return who spent most" do
      file_name = "report_test.csv"

      output =
        file_name
        |> ReportsGenerator.build()
        |> ReportsGenerator.fetch_higher_cost("users")

      expected_output = {:ok, {"5", 49}}

      assert output == expected_output
    end

    test "when the option is 'foods' return the most consumed food" do
      file_name = "report_test.csv"

      output =
        file_name
        |> ReportsGenerator.build()
        |> ReportsGenerator.fetch_higher_cost("foods")

      expected_output = {:ok, {"esfirra", 3}}

      assert output == expected_output
    end

    test "when invalid input, returns error" do
      file_name = "report_test.csv"

      output =
        file_name
        |> ReportsGenerator.build()
        |> ReportsGenerator.fetch_higher_cost("invalid")

      expected_output = {:error, "Invalid option"}

      assert output == expected_output
    end
  end
end
