

package body Home_Containers.Substrings is

   procedure Allocate (Item : in out Substring; Length : Natural) is
   begin
      Item.Data := new String (1 .. Length);
      Item.First := 1;
      Item.Last := 0;
   end;

   procedure Delete_First (Item : in out Substring; Count : Natural) is
   begin
      Item.First := Count;
   end;

   function Data_Address (Item : in out Substring) return System.Address is
   begin
      return Item.Data (Item.First .. Item.First)'Address;
   end Data_Address;

end;
