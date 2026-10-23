module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<185> : tensor<5x5x2x10xi16>}> : () -> tensor<5x5x2x10xi16>
    %1 = "tosa.const"() <{values = dense<146> : tensor<5x1x1x1xi16>}> : () -> tensor<5x1x1x1xi16>
    %2 = "tosa.const"() <{values = dense<-3.647000e+01> : tensor<4xf32>}> : () -> tensor<4xf32>
    %3 = tosa.sub %0, %1 : (tensor<5x5x2x10xi16>, tensor<5x1x1x1xi16>) -> tensor<5x5x2x10xi16>
    %4 = tosa.tanh %2 : (tensor<4xf32>) -> tensor<4xf32>
    %5 = tosa.argmax %4 {axis = 0 : i32} : (tensor<4xf32>) -> tensor<i32>
    %6 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %7 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %8 = tosa.negate %5, %6, %7 : (tensor<i32>, tensor<1xi32>, tensor<1xi32>) -> tensor<i32>
    %9 = tosa.logical_left_shift %3, %3 : (tensor<5x5x2x10xi16>, tensor<5x5x2x10xi16>) -> tensor<5x5x2x10xi16>
    %cast = tensor.cast %8 : tensor<i32> to tensor<*xi32>
    %cast_0 = tensor.cast %9 : tensor<5x5x2x10xi16> to tensor<*xi16>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefI16(%cast_0) : (tensor<*xi16>) -> ()
    return
  }
}

