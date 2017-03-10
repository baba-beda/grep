{-# LANGUAGE LambdaCase  #-}
{-# LANGUAGE QuasiQuotes #-}

module Main where

import qualified Data.Text          as T
import qualified Data.Text.IO       as TIO
import           System.Environment (getArgs)
import           Text.RawString.QQ

import           Grep

main :: IO ()
main =
    getArgs >>= \case
        [substr, fileName] -> do
            contentLines <- T.lines <$> TIO.readFile fileName
            mapM_ TIO.putStrLn $ grep (T.pack substr) contentLines
        _ -> failWrongArgs
  where
    failWrongArgs =
        error $ [r|
        Too few arguments
        The right execution should look like:
        "grep <not_empty_string> <filepath>"|]
