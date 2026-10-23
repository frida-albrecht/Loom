module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-131> : tensor<5x4x4x4xi32>}> : () -> tensor<5x4x4x4xi32>
    %1 = "tosa.const"() <{values = dense<-166> : tensor<1x1x4x4xi32>}> : () -> tensor<1x1x4x4xi32>
    %2 = "tosa.const"() <{values = dense<-84.4499969> : tensor<8x9xf32>}> : () -> tensor<8x9xf32>
    %3 = tosa.minimum %0, %1 : (tensor<5x4x4x4xi32>, tensor<1x1x4x4xi32>) -> tensor<5x4x4x4xi32>
    %4 = tosa.argmax %3 {axis = 1 : i32} : (tensor<5x4x4x4xi32>) -> tensor<5x4x4xi32>
    %5 = tosa.rsqrt %2 : (tensor<8x9xf32>) -> tensor<8x9xf32>
    %6 = tosa.exp %5 : (tensor<8x9xf32>) -> tensor<8x9xf32>
    %7 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %8 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %9 = tosa.negate %5, %7, %8 : (tensor<8x9xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<8x9xf32>
    %10 = tosa.arithmetic_right_shift %4, %4 {round = true} : (tensor<5x4x4xi32>, tensor<5x4x4xi32>) -> tensor<5x4x4xi32>
    %cast = tensor.cast %6 : tensor<8x9xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %9 : tensor<8x9xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %10 : tensor<5x4x4xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_1) : (tensor<*xi32>) -> ()
    return
  }
}

