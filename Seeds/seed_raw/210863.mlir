module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<59> : tensor<8xi32>}> : () -> tensor<8xi32>
    %1 = "tosa.const"() <{values = dense<-1.959900e+02> : tensor<8xf32>}> : () -> tensor<8xf32>
    %2 = tosa.clamp %0 {max_val = 133 : i32, min_val = 23 : i32} : (tensor<8xi32>) -> tensor<8xi32>
    %3 = tosa.reciprocal %1 : (tensor<8xf32>) -> tensor<8xf32>
    %4 = tosa.reciprocal %3 : (tensor<8xf32>) -> tensor<8xf32>
    %5 = tosa.minimum %3, %4 : (tensor<8xf32>, tensor<8xf32>) -> tensor<8xf32>
    %6 = tosa.bitwise_or %2, %2 : (tensor<8xi32>, tensor<8xi32>) -> tensor<8xi32>
    %7 = tosa.bitwise_not %6 : (tensor<8xi32>) -> tensor<8xi32>
    %8 = tosa.bitwise_xor %7, %2 : (tensor<8xi32>, tensor<8xi32>) -> tensor<8xi32>
    %cast = tensor.cast %5 : tensor<8xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %8 : tensor<8xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

