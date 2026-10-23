module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<48> : tensor<4xi32>}> : () -> tensor<4xi32>
    %1 = "tosa.const"() <{values = dense<87> : tensor<4xi32>}> : () -> tensor<4xi32>
    %2 = "tosa.const"() <{values = dense<-3.834000e+01> : tensor<10x5x2x7xf32>}> : () -> tensor<10x5x2x7xf32>
    %3 = tosa.bitwise_xor %0, %1 : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi32>
    %4 = tosa.identity %3 : (tensor<4xi32>) -> tensor<4xi32>
    %5 = tosa.sigmoid %2 : (tensor<10x5x2x7xf32>) -> tensor<10x5x2x7xf32>
    %6 = tosa.arithmetic_right_shift %4, %3 {round = true} : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi32>
    %7 = tosa.bitwise_or %6, %6 : (tensor<4xi32>, tensor<4xi32>) -> tensor<4xi32>
    %8 = tosa.clamp %7 {max_val = -28 : i32, min_val = -51 : i32} : (tensor<4xi32>) -> tensor<4xi32>
    %9 = tosa.reverse %5 {axis = 1 : i32} : (tensor<10x5x2x7xf32>) -> tensor<10x5x2x7xf32>
    %cast = tensor.cast %8 : tensor<4xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %9 : tensor<10x5x2x7xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

