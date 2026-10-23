module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-89> : tensor<8x3xi32>}> : () -> tensor<8x3xi32>
    %1 = "tosa.const"() <{values = dense<2> : tensor<1x3xi32>}> : () -> tensor<1x3xi32>
    %2 = "tosa.const"() <{values = dense<-1.622700e+02> : tensor<10x9xf32>}> : () -> tensor<10x9xf32>
    %3 = tosa.add %0, %1 : (tensor<8x3xi32>, tensor<1x3xi32>) -> tensor<8x3xi32>
    %4 = tosa.clamp %3 {max_val = 34 : i32, min_val = 11 : i32} : (tensor<8x3xi32>) -> tensor<8x3xi32>
    %5 = tosa.clamp %4 {max_val = 34 : i32, min_val = 11 : i32} : (tensor<8x3xi32>) -> tensor<8x3xi32>
    %6 = tosa.tanh %2 : (tensor<10x9xf32>) -> tensor<10x9xf32>
    %cast = tensor.cast %5 : tensor<8x3xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %6 : tensor<10x9xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

