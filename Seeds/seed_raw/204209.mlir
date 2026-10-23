module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<false> : tensor<7x10x2xi1>}> : () -> tensor<7x10x2xi1>
    %1 = "tosa.const"() <{values = dense<false> : tensor<7x2x9xi1>}> : () -> tensor<7x2x9xi1>
    %2 = "tosa.const"() <{values = dense<false> : tensor<1xi1>}> : () -> tensor<1xi1>
    %3 = "tosa.const"() <{values = dense<false> : tensor<1xi1>}> : () -> tensor<1xi1>
    %4 = tosa.matmul %0, %1, %2, %3 : (tensor<7x10x2xi1>, tensor<7x2x9xi1>, tensor<1xi1>, tensor<1xi1>) -> tensor<7x10x9xi1>
    %5 = tosa.argmax %4 {axis = 0 : i32} : (tensor<7x10x9xi1>) -> tensor<10x9xi32>
    %6 = tosa.reverse %5 {axis = 1 : i32} : (tensor<10x9xi32>) -> tensor<10x9xi32>
    %7 = tosa.bitwise_xor %6, %6 : (tensor<10x9xi32>, tensor<10x9xi32>) -> tensor<10x9xi32>
    %8 = tosa.minimum %7, %7 : (tensor<10x9xi32>, tensor<10x9xi32>) -> tensor<10x9xi32>
    %9 = tosa.clamp %8 {max_val = 90 : i32, min_val = -28 : i32} : (tensor<10x9xi32>) -> tensor<10x9xi32>
    %cast = tensor.cast %9 : tensor<10x9xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

