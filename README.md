CHActivityEllipses
==================

An activity indicator that is an animating ellipses with customizable size and colors.

### Initialization
    -(id)initWithSize:(CGFloat)size backgroundColor:(UIColor *)bgc dotColor:(UIColor *)dc;
  
#### You can edit the background color after initialization
    @property (nonatomic, strong) UIColor *bgColor;
    
#### You can edit the dot color after initializtion
    @property (nonatomic, strong) UIColor *dotColor;

### Start the activity
    -(void)startActivity;
    
### Stop the activity
    -(void)stopActivity;
