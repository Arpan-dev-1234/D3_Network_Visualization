# ETC_5147_D3_Rshiny_projects

Some Programming exercise files on Rshiny and D3:

# Tasks on Rshiny:

1. Create a visualisation using ggplot to show the top 5 genera by count (VIS1).
2. Create a visualisation using ggplot to show the distribution of life expectancy for each of the top 5 genus (VIS2).
3. Create an interactive proportional symbol map using leaflet showing all the tree locations of these top 5 genus (MAP): 
4. Compose the VIS1, VIS2, MAP, and your findings into a nice layout (preferably using fixed layout instead of fluid layout).

# Tasks on D3:
1. The task is to create a network visualisation using the provided dataset and HTML template. The network visualisation shows the interaction among characters in the movie ‘Lord of The Rings: The Return of The King’.
2. You need to perform the following tasks:
Using the provided HTML template (the dataset is stored online and the path is provided in the template) , create a network visualisation with the following specifications (Static Network Visualisation and Interactions):

1. Each node represents a character.
2. Draw a circle for each node and label them with text showing the name of the character.
3. Each link represents the interaction between two characters.
4. Draw a line for each link and encode the character interaction count (named as ‘weight’ in the dataset) to the thickness of the line.
5. Use force directed layout (see Notes for hints).
6. Highlight two links and their two node labels: 1) the link between GANDALF and PIPPIN, 2) the link between FRODO and SAM. For highlighting, you are encouraged to use the two css classes provided in the template: .highlight-link (for link), and  .highlight-text (for text). It is fine if you are not using these two css classes, but you have to make sure that the highlighted links and text for the label stands out from the others.
