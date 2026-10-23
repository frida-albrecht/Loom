module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-127> : tensor<9x4x8x9xi16>}> : () -> tensor<9x4x8x9xi16>
    %1 = "tosa.const"() <{values = dense<-157> : tensor<1x1x1x1xi16>}> : () -> tensor<1x1x1x1xi16>
    %2 = "tosa.const"() <{values = dense<4.492000e+01> : tensor<1x8xf32>}> : () -> tensor<1x8xf32>
    %3 = "tosa.const"() <{values = dense<7.220000e+00> : tensor<1x1xf32>}> : () -> tensor<1x1xf32>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<1x1x1x1xi16>}> : () -> tensor<1x1x1x1xi16>
    %cl1 = tosa.maximum %1, %c0 : (tensor<1x1x1x1xi16>, tensor<1x1x1x1xi16>) -> tensor<1x1x1x1xi16>
    %c15 = "tosa.const"() <{values = dense<15> : tensor<1x1x1x1xi16>}> : () -> tensor<1x1x1x1xi16>
    %cl2 = tosa.minimum %cl1, %c15 : (tensor<1x1x1x1xi16>, tensor<1x1x1x1xi16>) -> tensor<1x1x1x1xi16>
    %4 = tosa.logical_left_shift %0, %cl2 : (tensor<9x4x8x9xi16>, tensor<1x1x1x1xi16>) -> tensor<9x4x8x9xi16>
    %5 = "tosa.const"() <{values = dense<[0, 3, 1, 2]> : tensor<4xi32>}> : () -> tensor<4xi32>
    %6 = tosa.transpose %4 {perms = array<i32: 0, 3, 1, 2>} : (tensor<9x4x8x9xi16>) -> tensor<9x9x4x8xi16>
    %7 = tosa.pow %2, %3 : (tensor<1x8xf32>, tensor<1x1xf32>) -> tensor<1x8xf32>
    %cast = tensor.cast %6 : tensor<9x9x4x8xi16> to tensor<*xi16>
    %cast_0 = tensor.cast %7 : tensor<1x8xf32> to tensor<*xf32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}