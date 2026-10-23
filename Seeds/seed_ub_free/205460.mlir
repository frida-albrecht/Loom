module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-8.948000e+01> : tensor<1x5x9x7xf32>}> : () -> tensor<1x5x9x7xf32>
    %1 = "tosa.const"() <{values = dense<4.563000e+01> : tensor<1x5x1x7xf32>}> : () -> tensor<1x5x1x7xf32>
    %2 = "tosa.const"() <{values = dense<155> : tensor<7xi16>}> : () -> tensor<7xi16>
    %3 = "tosa.const"() <{values = dense<66> : tensor<7xi16>}> : () -> tensor<7xi16>
    %4 = tosa.add %0, %1 : (tensor<1x5x9x7xf32>, tensor<1x5x1x7xf32>) -> tensor<1x5x9x7xf32>
    %5 = tosa.ceil %4 : (tensor<1x5x9x7xf32>) -> tensor<1x5x9x7xf32>
    %6 = tosa.reciprocal %5 : (tensor<1x5x9x7xf32>) -> tensor<1x5x9x7xf32>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<7xi16>}> : () -> tensor<7xi16>
    %c15 = "tosa.const"() <{values = dense<15> : tensor<7xi16>}> : () -> tensor<7xi16>
    %clamped_lower = tosa.maximum %3, %c0 : (tensor<7xi16>, tensor<7xi16>) -> tensor<7xi16>
    %safe_shift = tosa.minimum %clamped_lower, %c15 : (tensor<7xi16>, tensor<7xi16>) -> tensor<7xi16>
    %7 = tosa.logical_left_shift %2, %safe_shift : (tensor<7xi16>, tensor<7xi16>) -> tensor<7xi16>
    %8 = tosa.reduce_max %6 {axis = 2 : i32} : (tensor<1x5x9x7xf32>) -> tensor<1x5x1x7xf32>
    %cast = tensor.cast %7 : tensor<7xi16> to tensor<*xi16>
    %cast_0 = tensor.cast %8 : tensor<1x5x1x7xf32> to tensor<*xf32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}