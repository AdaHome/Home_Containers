package body Home_Containers.Generic_Vectors is

   procedure Empty (Container : out Vector) is
   begin
      Container.Last := 0;
   end;

   procedure Append (Container : in out Vector) is
   begin
      Container.Last := Container.Last + 1;
   end;

   procedure Append (Container : in out Vector; New_Item : Element) is
   begin
      Container.Last := Container.Last + 1;
      Container.Data (Container.Last) := New_Item;
   end;

   function Data_Address (Container : Vector) return Address is
   begin
      return Container.Data'Address;
   end;

   function Data_Size (Container : Vector) return Natural is
   begin
      return Container.Data'Size;
   end;

   function Get_Reference (Container : in out Vector; K : Index) return Accessor is
   begin
      return Accessor'(Generic_Vectors_Element => Container.Data (K)'Access);
   end;

   function Get_Reference (Container : aliased in out Vector; Position : Cursor) return Accessor is
   begin
      return Accessor'(Generic_Vectors_Element => Container.Data (Position.Index)'Access);
   end;

   function Get_Constant_Reference (Container : aliased Vector; K  : Index) return Constant_Accessor is
   begin
      return Constant_Accessor'(Generic_Vectors_Element => Container.Data (K)'Access);
   end;

   function Get_Constant_Reference (Container : aliased Vector; Position  : Cursor) return Constant_Accessor is
   begin
      return Constant_Accessor'(Generic_Vectors_Element => Container.Data (Position.Index)'Access);
   end;

   function First_Element (C : in out Vector) return Accessor is
   begin
      return Accessor'(Generic_Vectors_Element => C.Data (C.Data'First)'Access);
   end;

   function First_Element1 (C : Vector) return Element is
   begin
      return C.Data (C.Data'First);
   end;

   function First_Index (C : Vector) return Base_Index is
   begin
      return C.Data'First;
   end;

   function Last_Element (C : in out Vector) return Accessor is
   begin
      return Accessor'(Generic_Vectors_Element => C.Data (C.Last)'Access);
   end;

   function Last_Element1 (C : Vector) return Element is
   begin
      return C.Data (C.Last);
   end;

   function Last_Index (C : Vector) return Base_Index is
   begin
      return C.Last;
   end;

   function Exists (Container : Vector; K : Base_Index) return Boolean is
   begin
      if K in Index and then K <= Container.Last then
         return True;
      else
         return False;
      end if;
   end;

   function Has_Element (Position : Cursor) return Boolean is
   begin
      return Position.Index <= Position.Container.Last;
   end;

   function First (Item : Iterator) return Cursor is
   begin
      return Position : Cursor do
         Position.Container := Item.Container;
         Position.Index := 1;
      end return;
   end;

   function Next (Item : Iterator; Position : Cursor) return Cursor is
      pragma Unreferenced (Item);
   begin
      return C : Cursor do
         C.Container := Position.Container;
         C.Index := Position.Index + 1;
      end return;
   end;

   function Iterate (Item : Vector) return Iterators.Forward_Iterator'Class is
   begin
      return I : Iterator do
         I.Container := Item'Unrestricted_Access;
      end return;
   end;

   function Length  (C : Vector) return Count is
   begin
      return C.Last;
   end;

   function Capacity  (C : Vector) return Count is
   begin
      return C.Capacity;
   end;

end;
