with Ada.Strings;
with System;

package Home_Containers.Substrings is

   type String_Access is access all String;

   type Substring is record
      Data : String_Access;
      First : Integer;
      Last : Integer;
   end record;

   procedure Delete_First (Item : in out Substring; Count : Natural);
   function Data_Address (Item : in out Substring) return System.Address;

end;
