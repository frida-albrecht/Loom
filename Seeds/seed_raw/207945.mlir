module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<29> : tensor<5x5x1xi64>}> : () -> tensor<5x5x1xi64>
    %1 = "tosa.const"() <{values = dense<69> : tensor<5x1x9xi64>}> : () -> tensor<5x1x9xi64>
    %2 = "tosa.const"() <{values = dense<1.118600e+02> : tensor<5x2x3xf32>}> : () -> tensor<5x2x3xf32>
    %3 = "tosa.const"() <{values = dense<53> : tensor<i32>}> : () -> tensor<i32>
    %4 = "tosa.const"() <{values = dense<64> : tensor<i32>}> : () -> tensor<i32>
    %5 = "tosa.const"() <{values = dense<0> : tensor<1xi64>}> : () -> tensor<1xi64>
    %6 = "tosa.const"() <{values = dense<0> : tensor<1xi64>}> : () -> tensor<1xi64>
    %7 = tosa.matmul %0, %1, %5, %6 : (tensor<5x5x1xi64>, tensor<5x1x9xi64>, tensor<1xi64>, tensor<1xi64>) -> tensor<5x5x9xi64>
    %8 = tosa.floor %2 : (tensor<5x2x3xf32>) -> tensor<5x2x3xf32>
    %9 = tosa.clz %7 : (tensor<5x5x9xi64>) -> tensor<5x5x9xi64>
    %10 = tosa.reciprocal %8 : (tensor<5x2x3xf32>) -> tensor<5x2x3xf32>
    %11 = tosa.intdiv %3, %4 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %12 = tosa.clz %11 : (tensor<i32>) -> tensor<i32>
    %13 = tosa.reduce_product %8 {axis = 2 : i32} : (tensor<5x2x3xf32>) -> tensor<5x2x1xf32>
    %14 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %15 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %16 = tosa.negate %11, %14, %15 : (tensor<i32>, tensor<1xi32>, tensor<1xi32>) -> tensor<i32>
    %17 = tosa.pow %13, %13 : (tensor<5x2x1xf32>, tensor<5x2x1xf32>) -> tensor<5x2x1xf32>
    %cast = tensor.cast %9 : tensor<5x5x9xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %10 : tensor<5x2x3xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %12 : tensor<i32> to tensor<*xi32>
    %cast_2 = tensor.cast %16 : tensor<i32> to tensor<*xi32>
    %cast_3 = tensor.cast %17 : tensor<5x2x1xf32> to tensor<*xf32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_1) : (tensor<*xi32>) -> ()
    call @printMemrefI32(%cast_2) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_3) : (tensor<*xf32>) -> ()
    return
  }
}

