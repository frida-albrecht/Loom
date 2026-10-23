module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-174> : tensor<5x4xi16>}> : () -> tensor<5x4xi16>
    %1 = "tosa.const"() <{values = dense<71.8899993> : tensor<1x4xf32>}> : () -> tensor<1x4xf32>
    %2 = "tosa.const"() <{values = dense<-180> : tensor<i32>}> : () -> tensor<i32>
    %3 = "tosa.const"() <{values = dense<-147> : tensor<i32>}> : () -> tensor<i32>
    %4 = tosa.reduce_max %0 {axis = 0 : i32} : (tensor<5x4xi16>) -> tensor<1x4xi16>
    %5 = tosa.floor %1 : (tensor<1x4xf32>) -> tensor<1x4xf32>
    %6 = tosa.const_shape  {values = dense<4> : tensor<1xindex>} : () -> !tosa.shape<1>
    %7 = tosa.reshape %5, %6 : (tensor<1x4xf32>, !tosa.shape<1>) -> tensor<4xf32>
    %8 = tosa.intdiv %2, %3 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %cast = tensor.cast %4 : tensor<1x4xi16> to tensor<*xi16>
    %cast_0 = tensor.cast %7 : tensor<4xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %8 : tensor<i32> to tensor<*xi32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_1) : (tensor<*xi32>) -> ()
    return
  }
}

