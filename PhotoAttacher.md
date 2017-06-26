#    PhotoAttacher manual.md   

## classes
* [TitleViewController](#title)
* [ScreenshotManager](#ssmanager)
* [SSChangeData](#sschangedata)
* [PhotoPickerViewController](#photopicker)
* [OthersViewController](#others)
* [UICollectionView(extension)](#collectionview+p)
* [SACollectionViewCell](#sacollectionview)
* [PreviewViewController](#preview)
* [EditorViewController](#editor)
* [OptionViewController](#option) 
* [SubEditorViewController](#subeditor) 
* [ImageCropperView](#cropper)

---

<a name="delegate"></a>
##   AppDelegate.swift
###  AppDelegate
#### const string
	//initialized value
	"PhotoAttacher_HasInitialized"           //true
	"PhotoAttacher_SimpleFlag"               //false
	"PhotoAttacher_AskToDust"                //false
	"PhotoAttacher_NoNumberForMenu"          //false
	"PhotoAttacher_BGColor_Red"              //0.54
	"PhotoAttacher_BGColor_Green"            //0.76
	"PhotoAttacher_BGColor_Blue"             //0.85
	"PhotoAttacher_SubEditorBGColor_Red"     //0.55
	"PhotoAttacher_SubEditorBGColor_Green"   //0.77
	"PhotoAttacher_SubEditorBGColor_Blue"    //0.47
	"PhotoAttacher_ButtonColor_Red"          //0.08
	"PhotoAttacher_ButtonColor_Green"        //0.38
	"PhotoAttacher_ButtonColor_Blue"         //0.29

#### related class 
* [TitleViewController](#title)

---

<a name="title"></a>
##   TitleViewController.swift
###  TitleViewController
	class TitleViewController: UIViewController , NADViewDelegate
#### variables
	//画面に表示されるボタン
    @IBOutlet var btnPortrait_Yoko   : BButton?
    @IBOutlet var btnPortrait_Tate   : BButton?
    @IBOutlet var btnLandscape_Tate  : BButton?
    @IBOutlet var btnPortrait_4in1   : BButton?
    @IBOutlet var btnLandscape_4in1  : BButton?
    @IBOutlet var btnOther : BButton?
	//使ってない
    @IBOutlet var segSimple : UISegmentedControl?
	//広告
    @IBOutlet var nadFrame : UIView?
    private var nadView : NADView!

#### overrides
	//見た目に関する処理しかない
    override func viewDidLoad()
    override func viewWillAppear(animated: Bool)
    override func viewDidLayoutSubviews()
    override func viewWillDisappear(animated: Bool)
	//アラートや遷移
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool 

#### related classes
* [ScreenshotManager](#ssmanager)
* [PhotoPickerViewController](#photopicker)
* [OthersViewController](#others)

---

##   PhotoPickerViewController.swift
<a name="photopicker"></a>
###  PhotoPickerViewController
	class PhotoPickerViewController : UICollectionViewController 
#### variables
    let maxSS = 30 //showAll == false のとき表示する数
    let maxSelection = 10 //連結数最大
    var showAll:Bool = false 
    let ssManager = ScreenshotManager.sharedManager
    var showSize = CGSizeZero //画面に表示するサイズ viewDidLoad()で指定
#### overrides
    override func viewDidLoad() 
    override func viewWillAppear(animated: Bool) 
    override func viewWillDisappear(animated: Bool) 
	//collection view としての仕事
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int 
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell 
    override func collectionView(collectionView: UICollectionView, didUnhighlightItemAtIndexPath indexPath: NSIndexPath) 
    override func collectionView(collectionView: UICollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath) 
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool 
    override func collectionView(collectionView: UICollectionView, shouldDeselectItemAtIndexPath indexPath: NSIndexPath) -> Bool 
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) 
    override func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) 
#### methods
    func setNextEnabled(enabled:Bool)
    @IBAction func toggleShowState()
    @IBAction func goNextStep()

#### const string
	//see AppDelegate.swift
	"PhotoAttacher_SimpleFlag"
	//storyboard
	"ToPreview"  
	"ToEditor"   
	
#### related classes
* [ScreenshotManager](#ssmanager)
* [UICollectionView(extension)](#collectionview+p)
* [SACollectionViewCell](#sacollectionview)
* [PreviewViewController](#preview)
* [EditorViewController](#editor)

---

##   UICollectionView+Private.swift
<a name="collectionview+p"></a>
###  UICollectionView(extension)
	extension UICollectionView
#### methods
    func refresh()

---

##   SACollectionViewCell.swift
<a name="sacollectionview"></a>
###  SACollectionViewCell
	class SACollectionViewCell : UICollectionViewCell
#### variables
    var badge:SAMBadgeView? = nil
    var image:UIImageView? = nil
#### overrides
    override func prepareForReuse() 
#### methods
    func readyLabel()
    func selectedWithNumber(number number:Int)
    func selectedForEdit()
    func deselected()
    func setScreenshotImage(img:UIImage)

---

##   EditorViewController.swift 
<a name="editor"></a>
###  EditorViewController
	class EditorViewController : UICollectionViewController ,UICollectionViewDataSource_Draggable,UIPopoverPresentationControllerDelegate
#### variables
    let ssManager = ScreenshotManager.sharedManager
    var selectedOrder : Int? = nil
    var showSize = CGSizeZero //画面に表示するサイズ viewDidLoad()で指定
#### overrides
	//view controller
    override func viewWillAppear(animated: Bool) 
    override func viewWillDisappear(animated: Bool) 
    override func viewDidLoad() 
	//collection view (draggable)
    override func collectionView(collectionView:UICollectionView,moveItemAtIndexPath fromIndexPath:NSIndexPath,toIndexPath:NSIndexPath)
    override func collectionView(collectionView: UICollectionView, canMoveItemAtIndexPath indexPath: NSIndexPath) -> Bool 
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int 
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell 
    override func collectionView(collectionView: UICollectionView, didUnhighlightItemAtIndexPath indexPath: NSIndexPath) 
    override func collectionView(collectionView: UICollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath) 
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) 
    override func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) 
	//segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) 
#### methods
    @IBAction func pushedOption()//option popover de present
	//protocol 
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle 
#### const string
	//segue
	"ToSubEditor"
#### related classes
* [OptionViewController](#option) 
* [SubEditorViewController](#subeditor) 
* [ScreenshotManager](#ssmanager)

---

##   OptionViewController.swift
<a name="option"></a>
###  OptionViewController
	class OptionViewController : UITableViewController
#### overrides
	//table view
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int 
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) 
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) 
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? 
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell 
#### methods
    init()
    required init?(coder aDecoder: NSCoder) 
#### const string
	//table cell no id
	"OptionCell"
#### related classes
* [ScreenshotManager](#ssmanager)

---

##   SubEditorViewController.swift
<a name="subeditor"></a>
###  SubEditorViewController
EditorViewControllerでリストされている画像を一つ選び、このVCで詳細の編集を行う。
画像はself.viewの中心に置かれ、スライドおよび拡大縮小ができる。
またcropperViewを使って、ぼかしや切取りの範囲を指定する。
	class SubEditorViewController : UIViewController,UIScrollViewDelegate
#### variables
    let cropperView = ImageCropperView()
    @IBOutlet var scrollView : UIScrollView!
    var targetImageOrder : Int? = nil
    let ssManager = ScreenshotManager.sharedManager
    var mode : Int = 0//preview(0) , blur(1) , crop(2)
    let margin : CGFloat = 20
    private var firstViewAppear = true
#### properties
    var btnUndo : UIBarButtonItem
    var btnRedo : UIBarButtonItem
    var btnExecute : UIBarButtonItem
    var canNextChange : Bool
#### overrides
	//set scrollView, cropperView, btn(changeMode), btnUndo, btnRedo, btn Execute
    override func viewDidLoad() 
	//trivial
    override func viewWillAppear(animated: Bool) 
    override func viewWillDisappear(animated: Bool) 
	//segue:"ToTemplates"
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) 
#### methods
	//self.view no frame no bar wo nozoita area no center wo return
    func viewCenter()->CGPoint
	//return minimum scale user can shrink
    func minimumScale()->CGFloat
	//cropperView no setImage(image) wo call
    func setImage(image:UIImage)
	//mode(preview, blur, crop)
    func changeMode()
	//cropperView no subframe wo uketori image ni effect wo apply
    func executeChange()
	//redo, undo function
    func redo()
    func undo()
	//byouga to button no setting
	//dekiagari no sample wo dynamic ni hyouji
    func reflesh()
	//called from viewWillApper(animated), scrollViewDidZoom(scrollView)
    func updateCropperViewPosition()
	//delegate(scrollview)
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? 
    func scrollViewDidZoom(scrollView: UIScrollView) 
#### const string
	"ToTemplates"
#### related classes
* [ImageCropperView](#cropper)
* [ScreenshotManager](#ssmanager)

---

##   ImageCropperView.swift
###  enum
	enum ImageCropperViewCropperMode:Int{
		case none=0,freely,vertically
	}
<a name="cropper"></a>
###  ImageCropperView
viewにimageViewとcornersを配置して、ユーザに範囲を指定させる
cropIndicatorはconersから計算される範囲を視覚的に示す
cropperModeによってcornersの移動に制限を与える
このクラスで最も重要なcornersの位置はinsetsで表現される
	class ImageCropperView : UIView 
#### variables
    private var corners = [SAMBadgeView]()
    private var imageView : UIImageView! = nil
    private var cropperMode : ImageCropperViewCropperMode = .none
	//hiddenはcropperHiddenで管理
    private var cropIndicator : UIView! = nil 
	//top,left,bottom,right
    private var insets : [CGFloat] = [0.0,0.0,0.0,0.0] 
    private let margin : CGFloat = 40//cropperを動かしやすくするため
    static let minCropBreadth : CGFloat = 20.0
#### properties
    private var cropperHidden : Bool 
    var subframe : CGRect
#### methods
	//ssmanager, super.init, initialize()
	init()
	//itsumono
	required init?(coder aDecoder: NSCoder) 
	//mode change, set badge mark
	func changeMode(mode:ImageCropperViewCropperMode)
	//imageView no setting
	func setImage(_image: UIImage) 
	//badge ni recognizer wo add, event wo
	//kono class(ImageCropperView) de uketoru
	//cropIndicator mo shokika
	private func initialize() 
	//insets wo reset, badge no ichi mo reset
	private func resetCornersPosition()
	//recognizer no event wo shori shite ii kanji ni suru
	@objc private func movedCropper(recognizer:UIPanGestureRecognizer)
#### related classes
* [ScreenshotManager](#ssmanager)

---

##   OthersViewController.swift
<a name="others"></a>
###  OthersViewController
	class OtherViewController : UITableViewController
#### overrides
    override func viewWillAppear(animated: Bool) 
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) 

---

##   PreviewViewController.swift
<a name="preview"></a>
###  PreviewViewController
	class PreviewViewController : UIViewController ,NADViewDelegate
#### variables
	//show preview image
    @IBOutlet var scrollView : UIScrollView!
	//image
    var combinedImage : UIImage! = nil
	//ssmanager
    let ssManager = ScreenshotManager.sharedManager
    //ad viewu
    var nadView_ue : NADView? = nil
    var nadView_shita : NADView? = nil
#### properties 
	//save shite ato shori
    var btnSave : UIBarButtonItem{
        return self.toolbarItems![1]
    }
	//image saving no call back(*1) de okonau ato shori no closure
    var popupChange : (()->())? = nil
#### overrides
	//setBackgroundColor()
	override func viewDidLoad() 
	//scrollView<-imgView<-combinedImage<-size
	override func viewWillAppear(animated: Bool) 
	//nav. bar, nadView
	override func viewWillDisappear(animated: Bool) 
	//saveScreenshot() kara segue wo kidou
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) 
#### methods
	//migi shita no hozon button 
	//hozon to ato shori (iroiro hyoji)
	@IBAction func saveScreenshot()
	//hidari ue no hitotsu modoru button
	func pushedBack()
	//(*1) call back of saving image 
	func image(image: UIImage, didFinishSavingWithError error: NSError!, contextInfo: UnsafeMutablePointer<Void>) 
#### const string
	"ToIndicator"
	"PhotoAttacher_AskToDust"
#### related classes
* [ScreenshotManager](#ssmanager)

---

##   ScreenshotManager.swift
###  enum
	enum CombineType:Int{
		case Portrait_Vertical=0,Portrait_Horizontal,Landscape_Vertical,Portrait_4in1,Landscape_4in1
	}
<a name="sschangedata"></a>
###  SSChangeData
ScreenshotManagerでは必要に応じて（アンドゥ、リドゥ）
履歴を遡ったり、進めたりする
このクラスはデザインパターン（コマンド）で
image変更の履歴の一点を表現する
NSCodingに準拠するため@objcを付ける必要があり、structでは実装できない
	class SSChangeData:NSObject,NSCoding
#### enum
    enum SSChangeType:Int{
        case Blur,Crop
    }
#### variables
    var type : SSChangeType
    var subframe:CGRect //0.0f~1.0f
#### properties
	//description
    override var description : String
#### methods
    init(type:SSChangeType,subframe:CGRect)
	//NSCoding
    @objc required init?(coder aDecoder: NSCoder) 
    @objc func encodeWithCoder(aCoder: NSCoder) 
#### const string
	//NSCoding keys
	"typeValue"
	"subframe"

---

<a name="ssmanager"></a>
###  ScreenshotManager
indexはカメラロールでの順番
orderはユーザが選んだ順番
	class ScreenshotManager 
#### variables
	//ssmanager
    static let sharedManager = ScreenshotManager()
	//画像一覧
    private var screenshotAssets = [PHAsset]()
	//init()で初期化してimageHandleWithIndex(...)でしか使わない
	//あとで消す
    private var op = PHImageRequestOptions()
    //重要なデータ
    //index
    //changeStackData
    //order <- imageHandleWithPickup~ にorderを伝える
    private var pickupScreenshotData = [[String:Any]]()
    //option
    //indexingはこのクラスで利用
    //sizenotdownはpreviewで利用
    var optionSizeNotDown = false
	//-1 none,0-3 hidariue,migiue,hidarishita,migishita
    var optionIndexing = -1
#### properties
	//type このクラスの中では省略名cTypeが使える
    private var cType : CombineType! = nil{
        didSet{
            if cType == .Portrait_4in1 || cType == .Landscape_4in1{
                optionSizeNotDown = false
            }else{
                optionSizeNotDown = true
            }
        }
    }
	//外部からは長い名前しか使えない
    var combineType : CombineType!{
        return cType
    }
    var numberOfAssets : Int {
        return screenshotAssets.count
    }
    var numberOfPicked : Int{
        return pickupScreenshotData.count
    }
#### methods
	//opの設定をするだけ　あとで消す
	init()
	//スクリーンサイズを返す nativeFlagが0だとポイントで、1だと画素
	func screenSizeTupple(nativeFlag nativeFlag:Bool)->(Int,Int)
	//combineTypeを設定し、ssmanagerの準備をする
	//具体的にはassetsを探索して配列にまとめ、エラー値か正常値を返す
	func prepareForManager(combineType combineType:CombineType)->Int
	//closureを渡しindexの画像に処理をする
	//4in1などでは-1を渡してロゴで代用
	func imageHandleWithIndex(index:Int,size:CGSize,handling:(UIImage)->())
	//保存後に呼ぶ。消すかどうかはユーザのアクションに委ねられる
	func requestDeletingPckedAssets()
#### extension combine
	//dstのサイズを計算する
	//基準となるaSizeから全体をあらかじめ計算する
	//cropを考慮している
	func destinationImageSize(aSize:CGSize)->CGSize
	//実際に結合画像を生成している 
	//? clではなく普通に完成画像をreturnできないか？
	func combinedImageHandle(aSize:CGSize,cl:UIImage -> ())
    //index,-1ロゴ画像生成
	func logoWithSize(size:CGSize)->UIImage
#### extension picked data manipulator
	//remove, order系
	func resetPickupScreenshotData()
	func removeLastPickupScreenshotData()
	func removePickupScreenshotDataWithOrder(order:Int)
	//stack == change history
	func getChangeDataStack(order:Int)->Stack<SSChangeData>
	func setChangeDataStack(order:Int,stack:Stack<SSChangeData>)
	//collection view(draggable)
	func swapPickupScreenshotData(orderA:Int,orderB:Int)
	//order<-index
	func orderForIndex(index:Int)->Int?
	//getter
	func pickAssetWithIndex(index:Int)
	//design(memento) of change data
	func registerChange(order:Int,data:SSChangeData)
	func changeUndo(order:Int)
	func changeRedo(order:Int)
	func canChangeRedo(order:Int)->Bool
	func canChangeUndo(order:Int)->Bool
	func canNextChange(order:Int)->Bool
	//pickupscreenshotdataはpsdataの配列でpsdataは"index","changeStackData","order"をキーにもつ連想配列
	//"order"は番号バッジをつけるために必要
	//各画像の変更はここで施す(blur, crop)
	func imageHandleWithPickupScreenshotData(psdata:[String:Any],size:CGSize,drawMode:Int,handling:(UIImage)->())
	//使ってるのか不明
	func imageHandleWithOrder(order:Int,size:CGSize,drawMode:Int,handling:(UIImage)->())
	//背景に関する処理 
    //managerでやる処理ではない 1(sub editor),3(editor)
	func getSubEditorBackgroundColor(drawMode:Int)->(CGFloat,CGFloat,CGFloat)
#### const string
	"PhotoAttacher_BGColor_Red"
	"PhotoAttacher_BGColor_Green"
	"PhotoAttacher_BGColor_Blue"
	"PhotoAttacher_SubEditorBGColor_Red"
	"PhotoAttacher_SubEditorBGColor_Green"
	"PhotoAttacher_SubEditorBGColor_Blue"

---

