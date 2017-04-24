-- Table for menu that stores all the menus
-- Each menu has its ID and its name
CREATE TABLE Menu(
	MenuID INT,
	MenuName TEXT,
	PRIMARY KEY (MenuID)
);

-- Table to store all recipes
-- Each recipes has its unique ID and its dish's name
CREATE TABLE Recipe(
	RecipeID INT,
	DishName TEXT,
	PRIMARY KEY (RecipeID)
);

-- inside a menu we have multiple recipes
-- Assume all menu can not have repeated recipe, the primary key is combination of MenuID and RecipeID
-- If a recipe or menu is deleted, the relation in this form does not make sense. So for these two foreign key, we set on delete casecade
CREATE TABLE MenuRecipe(
	MenuID INT,
	RecipeID INT,
	PRIMARY KEY (MenuID, RecipeID),
	FOREIGN KEY (RecipeID) REFERENCES Recipe(RecipeID) ON DELETE CASCADE,
	FOREIGN KEY (MenuID) REFERENCES Menu(MenuID) ON DELETE CASCADE
);

-- Table to store all ingredients
-- Each ingredient has its unique ID and its name
CREATE TABLE Ingredient(
	IngredientID INT,
	IngredientName TEXT,
	PRIMARY KEY (IngredientID)
);

-- Table to store all instructions
-- Each ingredient has its unique ID and its content
CREATE TABLE Instruction(
	InstructionID INT,
	InstructionContent TEXT,
	PRIMARY KEY (InstructionID)
);

-- This table record each recipe's ingredients
-- One ingredient can be used in multiple recipes
-- One recipe can have multiple ingredients
-- One ingredient can occur in one recipe once, so the primary key is combination of recipeID and IngredientID
CREATE TABLE RecipeIngredient(
	RecipeID INT,
	IngredientID INT,
	PRIMARY KEY (RecipeID, IngredientID),
	FOREIGN KEY (RecipeID) REFERENCES Recipe(RecipeID) ON DELETE CASCADE,
	FOREIGN KEY (IngredientID) REFERENCES Ingredient(IngredientID) ON DELETE CASCADE
);

-- This table record each recipe's instructions
-- One recipe can have multiple instructions
-- The content of instruction is a step like wash ingredient, so one instruction can be used in multiple recipes
-- The OrderNumber record the instruction's order. I think the instruction does not make sense if they are randomly put together in a recipe.
-- As we know, for each recipe, there is only one order of instruction, so the primary key is the combination of recipeID and OrderNumber
CREATE TABLE RecipeInstruction(
	RecipeID INT,
	InstructionID INT,
	OrderNumber INT,
	PRIMARY KEY (RecipeID, OrderNumber),
	FOREIGN KEY (RecipeID) REFERENCES Recipe(RecipeID) ON DELETE CASCADE,
	FOREIGN KEY (InstructionID) REFERENCES Instruction(InstructionID) ON DELETE CASCADE
);
