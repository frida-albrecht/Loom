module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-161> : tensor<4x3xi32>}> : () -> tensor<4x3xi32>
    %1 = "tosa.const"() <{values = dense<1.295800e+02> : tensor<10x2x8x10xf32>}> : () -> tensor<10x2x8x10xf32>
    %2 = tosa.reduce_min %0 {axis = 1 : i32} : (tensor<4x3xi32>) -> tensor<4x1xi32>
    %3 = tosa.clamp %2 {max_val = 1 : i32, min_val = -13 : i32} : (tensor<4x1xi32>) -> tensor<4x1xi32>
    %4 = tosa.bitwise_not %3 : (tensor<4x1xi32>) -> tensor<4x1xi32>
    %5 = tosa.ceil %1 : (tensor<10x2x8x10xf32>) -> tensor<10x2x8x10xf32>
    %6 = tosa.logical_left_shift %4, %2 : (tensor<4x1xi32>, tensor<4x1xi32>) -> tensor<4x1xi32>
    %7 = tosa.ceil %5 : (tensor<10x2x8x10xf32>) -> tensor<10x2x8x10xf32>
    %cast = tensor.cast %6 : tensor<4x1xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %7 : tensor<10x2x8x10xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

