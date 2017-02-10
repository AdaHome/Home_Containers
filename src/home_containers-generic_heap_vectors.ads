with System;
with Ada.Iterator_Interfaces;


generic
   type Element is private;
package Home_Containers.Generic_Heap_Vectors is

   type Cursor is private;
   function Has_Element (Position : Cursor) return Boolean;
   package Iterators is new Ada.Iterator_Interfaces (Cursor, Has_Element);
   type Iterator is new Iterators.Forward_Iterator with private;
   overriding function First (Item : Iterator) return Cursor;
   overriding function Next (Item : Iterator; Position : Cursor) return Cursor;

   subtype Address is System.Address;

   type Base_Index is new Integer;
   subtype Count is Base_Index range 0 .. Base_Index'Last;
   subtype Index is Base_Index range 1 .. Base_Index'Last;

   type Vector is tagged private with
     Variable_Indexing => Get_Reference,
     --Constant_Indexing => Constant_Reference,
     Iterator_Element  => Element,
     Default_Iterator  => Iterate;
   type Vector_Access is access all Vector;

   function Iterate (Item : Vector) return Iterators.Forward_Iterator'Class;

   type Accessor (Generic_Vectors_Element : not null access Element) is private with
     Implicit_Dereference => Generic_Vectors_Element;

   procedure Empty (Container : out Vector);

   function Get_Reference (C : in out Vector; K : Index) return Accessor;
   function Get_Reference (Container : aliased in out Vector; Position : Cursor) return Accessor;

   procedure Append (Container : in out Vector);
   procedure Append (Container : in out Vector; New_Item : Element);

   function Data_Address (Container : Vector) return Address;
   function Data_Size (Container : Vector) return Natural;


   No_Index : constant Base_Index := Index'Pred (Index'First);
   function Exists (Container : Vector; K : Base_Index) return Boolean;

   function First_Index (C : Vector) return Base_Index;
   function First_Element (C : in out Vector) return Accessor;
   function First_Element1 (C : Vector) return Element;
   function Last_Index (C : Vector) return Base_Index;
   function Last_Element (C : in out Vector) return Accessor;
   function Last_Element1 (C : Vector) return Element;

   procedure Allocate (C : in out Vector; Size : Count);
   procedure Free (C : in out Vector);

private

   type Element_Array is array (Index range <>) of aliased Element;
   type Element_Array_Access is access all Element_Array;

   type Cursor is record
      Container : Vector_Access;
      Index : Base_Index := 1;
   end record;

   type Iterator is new Iterators.Forward_Iterator with record
      Container : Vector_Access;
   end record;

   type Vector is tagged record
      Data : Element_Array_Access := null;
      Last : Base_Index := 0;
   end record;

   type Accessor (Generic_Vectors_Element : not null access Element) is null record;



end;
