{-# LANGUAGE NoImplicitPrelude #-}

module Data.Geo.Coordinate.DegreesLatitude(
  DegreesLatitude
, HasDegreesLatitude(..)
, nDegreesLatitude
) where

import Control.Category(Category(id))
import Control.Lens(Prism', Lens', prism')
import Data.Bool((&&))
import Data.Eq(Eq)
import Data.Int(Int)
import Data.Maybe(Maybe(Just, Nothing))
import Data.Ord(Ord((<), (>)))
import Prelude(Show)

-- $setup
-- >>> import Control.Lens((#), (^?))
-- >>> import Data.Foldable(all)
-- >>> import Prelude(Eq(..))

newtype DegreesLatitude =
  DegreesLatitude Int
  deriving (Eq, Ord, Show)

-- | A prism on degrees latitude to an integer between -90 and 90 exclusive.
--
-- >>> 7 ^? nDegreesLatitude
-- Just (DegreesLatitude 7)
--
-- >>> 0 ^? nDegreesLatitude
-- Just (DegreesLatitude 0)
--
-- >>> 89 ^? nDegreesLatitude
-- Just (DegreesLatitude 89)
--
-- >>> 90 ^? nDegreesLatitude
-- Nothing
--
-- >>> (-89) ^? nDegreesLatitude
-- Just (DegreesLatitude (-89))
--
-- >>> (-90) ^? nDegreesLatitude
-- Nothing
--
-- prop> all (\m -> nDegreesLatitude # m == n) (n ^? nDegreesLatitude)
nDegreesLatitude ::
  Prism' Int DegreesLatitude
nDegreesLatitude =
  prism'
    (\(DegreesLatitude i) -> i)
    (\i -> if i > -90 && i < 90
             then Just (DegreesLatitude i)
             else Nothing)

class HasDegreesLatitude t where
  degreesLatitude ::
    Lens' t DegreesLatitude

instance HasDegreesLatitude DegreesLatitude where
  degreesLatitude =
    id
