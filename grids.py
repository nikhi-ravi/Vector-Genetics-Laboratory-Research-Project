import cv2
import numpy as np

from custom_types.grid import Grid, Item, Row

# this class is responsible for detecting a grid of items
# the basic algorithm is as follows:
# 1. run a crude circle detection on the image
# 2. get the average radius of the detected circles
# 3. update the average radius and keep running until it converges
# 4. use the converged radius to run a more accurate circle detection
# 5. convert each circle into a rectangular grid item
# 6. sort the items into rows and columns



GRID_ROWS = 4
GRID_COLS = 6

SHOULD_EQUALIZE_HISTOGRAM = True
SHOULD_BLUR_FRAME = False
SHOULD_APPLY_BILATERAL_FILTER = False



class GridDetector:
    def __init__(self, frame):
        self.frame = frame
        if SHOULD_EQUALIZE_HISTOGRAM:
            self.clahe = cv2.createCLAHE(clipLimit=4, tileGridSize=(8, 8))
        self.processed_frame = None
        self.grid = None

    def process_frame(self):
        # implementation detail: I tried using the average of the first X frames,
        # but it didn't seem to make a difference, even at high values like 1000
        processed_frame = cv2.cvtColor(self.frame, cv2.COLOR_BGR2GRAY)
        if SHOULD_EQUALIZE_HISTOGRAM:
            processed_frame = self.clahe.apply(processed_frame)
        if SHOULD_BLUR_FRAME:
            processed_frame = cv2.medianBlur(processed_frame, 5)
        if SHOULD_APPLY_BILATERAL_FILTER:
            processed_frame = cv2.bilateralFilter(processed_frame, 9, 75, 75)
        return processed_frame

    def detect(self):
        self.process_frame = self.process_frame()
        height, width = self.frame.shape[:2]
        cell_width = width/GRID_COLS
        cell_height = height/GRID_ROWS


        grid = []
                        
        for row_index in range(GRID_ROWS):
            row_items = []
            for col_index in range (GRID_COLS):
                x1 = int(col_index*cell_width)
                y1 = int(row_index*cell_height)
                x2 = int((col_index +1)*cell_width)
                y2 = int((row_index +1)*cell_height)

                rect = ((x1, y1),(x2, y2),)

            #same indexing setup as the original code. 
                index = col_index*GRID_ROWS+row_index

                item = Item(
                    rect,
                    index,
                    (row_index, col_index),
                )

                row_items.append(item)

            grid.append(Row(row_items))

        grid = Grid(grid)

        self.grid = grid
        return grid
            
            
