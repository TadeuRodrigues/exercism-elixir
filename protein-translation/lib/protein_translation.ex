defmodule ProteinTranslation do
  @translate_condon_to_protein %{
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UGG" => "Tryptophan",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UAA" => "STOP",
    "UAG" => "STOP",
    "UGA" => "STOP"
  }
  
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna) do
    do_of_rna(rna, [])
  end

  defp do_of_rna(rna, result) do
    {curent_codon, rest_codons} = String.split_at(rna, 3)

    case of_codon(curent_codon) do
      {:ok, translation} -> do_of_rna(rest_codons, result ++ [translation])
      {:ok, "STOP"} -> {:ok, result}
      {:error, _} -> {:error, "invalid RNA"}
    end
  end

  defp do_of_rna("", result), do: {:ok, result}

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
    
  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) do
    case Map.fetch(@translate_condon_to_protein, codon) do
      :error -> {:error, "invalid codon"}
      {:ok, translate} -> {:ok, translate}
    end
  end
end
