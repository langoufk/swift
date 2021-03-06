// RUN: %empty-directory(%t)
// RUN: mkdir -p %t/clang-module-cache

// RUN: not %target-swift-frontend -scan-dependencies -module-cache-path %t/clang-module-cache %s -o %t/deps.json -I %S/Inputs/CHeaders -I %S/Inputs/Swift -emit-dependencies -emit-dependencies-path %t/deps.d -import-objc-header %S/Inputs/CHeaders/Bridging.h -swift-version 4 -disable-implicit-swift-modules -Xcc -Xclang -Xcc -fno-implicit-modules &> %t/out.txt

// RUN: %FileCheck %s < %t/out.txt

// CHECK: dependency scanner detected dependency cycle: 'CycleOne.swiftmodule -> CycleTwo.swiftmodule -> CycleThree.swiftmodule -> CycleOne.swiftmodule'

import CycleOne
