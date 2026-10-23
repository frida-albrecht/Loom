module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<158> : tensor<8x8x7xi16>}> : () -> tensor<8x8x7xi16>
    %1 = "tosa.const"() <{values = dense<-1.070000e+01> : tensor<8x6x10xf32>}> : () -> tensor<8x6x10xf32>
    %2 = "tosa.const"() <{values = dense<-72.4499969> : tensor<8x6x10xf32>}> : () -> tensor<8x6x10xf32>
    %3 = tosa.reduce_sum %0 {axis = 0 : i32} : (tensor<8x8x7xi16>) -> tensor<1x8x7xi16>
    %4 = tosa.greater %1, %2 : (tensor<8x6x10xf32>, tensor<8x6x10xf32>) -> tensor<8x6x10xi1>
    %5 = tosa.argmax %4 {axis = 1 : i32} : (tensor<8x6x10xi1>) -> tensor<8x10xi32>
    %cast = tensor.cast %3 : tensor<1x8x7xi16> to tensor<*xi16>
    %cast_0 = tensor.cast %5 : tensor<8x10xi32> to tensor<*xi32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

