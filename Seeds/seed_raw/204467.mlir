module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-61> : tensor<9x6x3xi16>}> : () -> tensor<9x6x3xi16>
    %1 = "tosa.const"() <{values = dense<-1.240000e+00> : tensor<9x4x4x1xf32>}> : () -> tensor<9x4x4x1xf32>
    %2 = tosa.reduce_sum %0 {axis = 0 : i32} : (tensor<9x6x3xi16>) -> tensor<1x6x3xi16>
    %3 = tosa.abs %2 : (tensor<1x6x3xi16>) -> tensor<1x6x3xi16>
    %4 = "tosa.const"() <{values = dense<0> : tensor<1xi16>}> : () -> tensor<1xi16>
    %5 = "tosa.const"() <{values = dense<0> : tensor<1xi16>}> : () -> tensor<1xi16>
    %6 = tosa.negate %3, %4, %5 : (tensor<1x6x3xi16>, tensor<1xi16>, tensor<1xi16>) -> tensor<1x6x3xi16>
    %7 = tosa.argmax %6 {axis = 2 : i32} : (tensor<1x6x3xi16>) -> tensor<1x6xi32>
    %8 = tosa.exp %1 : (tensor<9x4x4x1xf32>) -> tensor<9x4x4x1xf32>
    %9 = tosa.reduce_min %7 {axis = 1 : i32} : (tensor<1x6xi32>) -> tensor<1x1xi32>
    %10 = tosa.floor %8 : (tensor<9x4x4x1xf32>) -> tensor<9x4x4x1xf32>
    %11 = tosa.logical_right_shift %3, %3 : (tensor<1x6x3xi16>, tensor<1x6x3xi16>) -> tensor<1x6x3xi16>
    %cast = tensor.cast %9 : tensor<1x1xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %10 : tensor<9x4x4x1xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %11 : tensor<1x6x3xi16> to tensor<*xi16>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefI16(%cast_1) : (tensor<*xi16>) -> ()
    return
  }
}

