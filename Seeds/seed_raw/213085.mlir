module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-115> : tensor<8x10x4xi32>}> : () -> tensor<8x10x4xi32>
    %1 = tosa.reduce_max %0 {axis = 2 : i32} : (tensor<8x10x4xi32>) -> tensor<8x10x1xi32>
    %2 = tosa.concat %1, %1 {axis = 2 : i32} : (tensor<8x10x1xi32>, tensor<8x10x1xi32>) -> tensor<8x10x2xi32>
    %3 = tosa.clamp %2 {max_val = 20 : i32, min_val = -57 : i32} : (tensor<8x10x2xi32>) -> tensor<8x10x2xi32>
    %4 = tosa.bitwise_xor %3, %3 : (tensor<8x10x2xi32>, tensor<8x10x2xi32>) -> tensor<8x10x2xi32>
    %cast = tensor.cast %4 : tensor<8x10x2xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

