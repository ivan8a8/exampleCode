import ProjectDescription

let project = Project(
    name: "ExampleCode",
    organizationName: "Ivan Fabri",
    options: .options(developmentRegion: "en", disableBundleAccessors: true),
    settings: Settings.settings(
        base: SettingsDictionary()
            .marketingVersion("1.00")
            .currentProjectVersion("1")
            .merging([
                "INFOPLIST_KEY_LSApplicationCategoryType": "public.app-category.graphics-design"
            ]),
        defaultSettings: .recommended
    ),
    targets: [
        .target(
            name: "ExampleCode",
            destinations: [.iPhone, .iPad, .macWithiPadDesign],
            product: .app,
            bundleId: "com.ivanfabri.ExampleCode",
            deploymentTargets: .iOS("17.0"),
            infoPlist: "Sources/Info.plist",
            sources: [
                .glob("Sources/**/*"),
            ], resources: [
                .glob(pattern: "Sources/**/*", excluding: [
                    "Sources/**/*.swift",
                    "Sources/Info.plist"
                ])
            ],
            entitlements: "Sources/ExampleCode.entitlements",
            dependencies: [
                .external(name: "SDWebImage")
            ]
        )
    ],
    resourceSynthesizers: [.strings()]
)
