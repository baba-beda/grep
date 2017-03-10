{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TupleSections     #-}

module Grep
  (
  grep
  ) where

import           Data.Maybe  (catMaybes)
import           Data.Monoid ((<>))
import           Data.Text   (Text)
import qualified Data.Text   as T

grep :: Text -> [Text] -> [Text]
grep t _ | T.null t = ["Invalid input"]
grep s xs           =
    map concatWithNumbers $ catMaybes $ zipWith (curry checkLineI) xs [(1::Int)..]
  where
    checkLineI :: (Text, Int) -> Maybe ([Text], Int)
    checkLineI (line,i) =
        let l = grepLine s line
        in (,i) <$> (if null l then Nothing else Just l)
    concatWithNumbers :: ([Text], Int) -> Text
    concatWithNumbers (ws, i) = T.pack (show i) <> ": " <> T.intercalate ", " ws
    grepLine :: Text -> Text -> [Text]
    grepLine needle hay = filter (needle `T.isInfixOf`) $ T.words hay
