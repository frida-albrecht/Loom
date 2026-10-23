module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<84.2799987> : tensor<9x7x1x8xf32>}> : () -> tensor<9x7x1x8xf32>
    %1 = "tosa.const"() <{values = dense<96.7399978> : tensor<1x1x1x8xf32>}> : () -> tensor<1x1x1x8xf32>
    %2 = "tosa.const"() <{values = dense<-51> : tensor<10x9x7x5xi32>}> : () -> tensor<10x9x7x5xi32>
    %3 = "tosa.const"() <{values = dense<-61> : tensor<10x1x7x1xi32>}> : () -> tensor<10x1x7x1xi32>
    %4 = tosa.pow %0, %1 : (tensor<9x7x1x8xf32>, tensor<1x1x1x8xf32>) -> tensor<9x7x1x8xf32>
    %5 = tosa.logical_right_shift %2, %3 : (tensor<10x9x7x5xi32>, tensor<10x1x7x1xi32>) -> tensor<10x9x7x5xi32>
    %6 = tosa.bitwise_xor %5, %5 : (tensor<10x9x7x5xi32>, tensor<10x9x7x5xi32>) -> tensor<10x9x7x5xi32>
    %7 = tosa.add %6, %5 : (tensor<10x9x7x5xi32>, tensor<10x9x7x5xi32>) -> tensor<10x9x7x5xi32>
    %8 = tosa.log %4 : (tensor<9x7x1x8xf32>) -> tensor<9x7x1x8xf32>
    %9 = tosa.reverse %7 {axis = 2 : i32} : (tensor<10x9x7x5xi32>) -> tensor<10x9x7x5xi32>
    %10 = tosa.exp %8 : (tensor<9x7x1x8xf32>) -> tensor<9x7x1x8xf32>
    %cast = tensor.cast %9 : tensor<10x9x7x5xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %10 : tensor<9x7x1x8xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

